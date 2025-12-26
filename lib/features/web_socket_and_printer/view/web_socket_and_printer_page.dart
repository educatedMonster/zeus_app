import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
// import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import '../viewmodel/web_socket_and_printer_view_model.dart';
import 'widgets/web_socket_and_printer_app_bar.dart';

@RoutePage()
class WebSocketAndPrinterPage extends StatefulWidget {
  const WebSocketAndPrinterPage({super.key});

  @override
  State<WebSocketAndPrinterPage> createState() =>
      _WebSocketAndPrinterPageState();
}

class _WebSocketAndPrinterPageState extends State<WebSocketAndPrinterPage>
    with WidgetsBindingObserver {
  late WebSocketAndPrinterViewModel _web_socket_and_printerViewModel;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late ColorScheme _colorScheme;
  late Size _size;
  int _counter = 0;

  WebSocketChannel? _channel;
  final TextEditingController _controller = TextEditingController();

  // bool _isConnected = false;
  final String _agentId = 'flutter-agent-01';

  final String _printerIp = '192.168.12.200'; // Replace with your printer IP
  final int _printerPort = 9100;
  bool _isConnectedToPrinter = false;
  // PrinterNetworkManager? _printerNetworkManager;

  String? _platformVersion = 'Unknown';

  final MethodChannel _platform = MethodChannel('web_socket_service');
  String _status = 'Stopped';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _web_socket_and_printerViewModel = context.readWebSocketAndPrinterVM();
    _counter = _web_socket_and_printerViewModel.counter;
    _initControllers();
    _initPlatformState();
    _startService();
    _initPrinter2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _web_socket_and_printerViewModel = context.watchWebSocketAndPrinterVM();
    _counter = _web_socket_and_printerViewModel.counter;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: WebSocketAndPrinterAppBar(title: 'WEB SOCKET AND PRINTER'),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20.0.r,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: StreamBuilder(
                    stream: _channel?.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Text('Received: ${snapshot.data}'),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return Center(
                          child: Text(
                            _isConnectedToPrinter
                                ? 'Waiting for messages...'
                                : 'Disconnected. Trying to reconnect...',
                          ),
                        );
                      }
                    },
                  ),
                ),

                /// Connect to Printer
                ElevatedButton(
                  onPressed: _connectPrinter2,
                  child: const Text('Connect to Printer'),
                ),

                /// Print Receipt
                ElevatedButton(
                  onPressed: _printReceipt2,
                  child: const Text('Print Receipt'),
                ),

                /// Disconnect Printer
                ElevatedButton(
                  onPressed: _disconnectPrinter2,
                  child: const Text('Disconnect Printer'),
                ),
              ],
            ),

            /// Status
            Text(
              _isConnectedToPrinter
                  ? 'Status: Printer is Connected'
                  : 'Status: Printer is Disconnected',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.20,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ).r,
          child: Column(
            spacing: 8.0.r,
            children: [
              Flexible(
                child: TextFormField(
                  onTapOutside: (PointerDownEvent event) {
                    FocusScopeNode currentFocus = context.contextCurrentFocus();
                    if (!currentFocus.hasPrimaryFocus &&
                        currentFocus.focusedChild != null) {
                      currentFocus.focusedChild?.unfocus();
                    }
                  },
                  controller: _controller,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: 'Enter a message',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              /// Send
              ElevatedButton(
                onPressed: () {
                  const printJob = {
                    "type": 'print',
                    "printer": "printer name",
                    "payload": "payload",
                  };
                  _sendMessage(printJob); // send as JSON
                  _controller.clear();
                },
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: WebSocketAndPrinterFab(
      //   onPressed: _incrementCounter,
      // ),
    );
  }

  @override
  void didChangeDependencies() {
    _colorScheme = context.contextColorScheme();
    _size = context.contextSize();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _stopService();
    _disconnectPrinter2();
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    _web_socket_and_printerViewModel.incrementCounter();
  }

  void _initControllers() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _platform.invokeMethod<String>(
        'getPlatformVersion',
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _startService() async {
    try {
      final String result = await _platform.invokeMethod(
        'startWebbSocketService',
      );
      setState(() => _status = result);
    } on PlatformException catch (e) {
      setState(() => _status = "Failed: '${e.message}'");
    }
  }

  Future<void> _stopService() async {
    try {
      final String result = await _platform.invokeMethod(
        'stopWebSocketService',
      );
      setState(() => _status = result);
    } on PlatformException catch (e) {
      setState(() => _status = "Failed: '${e.message}'");
    }
  }

  Future<void> _sendMessage(Map<String, dynamic> data) async {
    try {
      final jsonString = jsonEncode(data); // convert Map → JSON string

      final String result = await _platform.invokeMethod('sendMessage', {
        'json': jsonString,
      });

      setState(() => _status = result);
    } on PlatformException catch (e) {
      setState(() => _status = "Failed: '${e.message}'");
    }
  }

  Future<void> _initPrinter2() async {
    try {
      final String result = await _platform.invokeMethod('initPrinter');
      setState(() => _status = result);
    } on PlatformException catch (e) {
      setState(() => _status = "Failed: '${e.message}'");
    }
  }

  Future<void> _connectPrinter2() async {
    try {
    String ip = '192.168.12.200';
      final String result = await _platform.invokeMethod('connectPrinter', {
        'ip': ip,
      });
      setState(() => _status = result);
    } on PlatformException catch (e) {
      setState(() => _status = "Failed: '${e.message}'");
    }
  }

  Future<void> _disconnectPrinter2() async {
    try {
      final String result = await _platform.invokeMethod('disconnectPrinter');

      setState(() {
        _status = result;
        _isConnectedToPrinter = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Printer disconnected')));
    } on PlatformException catch (e) {
      setState(() => _status = "Failed: '${e.message}'");
    }
  }

  Future<void> _printReceipt2() async {
    try {
      const printJob = {
        "type": 'print',
        "printer": "printer name",
        "payload": "payload",
      };

      final jsonString = jsonEncode(printJob); // convert Map → JSON string

      final String result = await _platform.invokeMethod('printReceipt');

      setState(() => _status = result);
    } on PlatformException catch (e) {
      setState(() => _status = "Failed: '${e.message}'");
    }
  }

  // Future<void> _initPrinter() async {
  //   _printerNetworkManager ??= PrinterNetworkManager(
  //     _printerIp,
  //     port: _printerPort,
  //   );
  // }
  //
  // Future<void> _connectPrinter() async {
  //   if (_printerNetworkManager == null) {
  //     await _initPrinter();
  //   }
  //
  //   final res = await _printerNetworkManager?.connect();
  //   setState(() {
  //     _isConnectedToPrinter = res == PosPrintResult.success;
  //   });
  //
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(
  //         _isConnectedToPrinter
  //             ? 'Printer connected!'
  //             : 'Printer connection failed: ${res?.msg ?? "Unknown error"}',
  //       ),
  //     ),
  //   );
  // }
  //
  // Future<void> _printReceipt() async {
  //   if (!_isConnectedToPrinter || _printerNetworkManager == null) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Printer not connected')));
  //     return;
  //   }
  //
  //   final profile = await CapabilityProfile.load();
  //   final generator = Generator(PaperSize.mm58, profile);
  //
  //   List<int> bytes = [];
  //
  //   // Header
  //   bytes += generator.text(
  //     'Flutter Store',
  //     styles: PosStyles(
  //       align: PosAlign.center,
  //       bold: true,
  //       height: PosTextSize.size2,
  //     ),
  //   );
  //   bytes += generator.text(
  //     '123 Main Street',
  //     styles: PosStyles(align: PosAlign.center),
  //   );
  //   bytes += generator.hr();
  //
  //   // Table
  //   bytes += generator.row([
  //     PosColumn(text: 'Item', width: 6),
  //     PosColumn(text: 'Qty', width: 3),
  //     PosColumn(text: 'Price', width: 3),
  //   ]);
  //   bytes += generator.row([
  //     PosColumn(text: 'Apples', width: 6),
  //     PosColumn(text: '2', width: 3),
  //     PosColumn(text: '\$4', width: 3),
  //   ]);
  //   bytes += generator.row([
  //     PosColumn(text: 'Bananas', width: 6),
  //     PosColumn(text: '3', width: 3),
  //     PosColumn(text: '\$6', width: 3),
  //   ]);
  //   bytes += generator.hr();
  //
  //   // QR code
  //   bytes += generator.qrcode('https://example.com', size: QRSize.size4);
  //
  //   bytes += generator.feed(2);
  //   bytes += generator.cut();
  //
  //   final printRes = await _printerNetworkManager!.printTicket(bytes);
  //
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(SnackBar(content: Text('Print result: ${printRes.msg}')));
  // }
  //
  // Future<void> _disconnectPrinter() async {
  //   if (_printerNetworkManager == null || !_isConnectedToPrinter) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Printer is not connected')));
  //     return;
  //   }
  //
  //   await _printerNetworkManager!.disconnect();
  //   setState(() {
  //     _isConnectedToPrinter = false;
  //   });
  //
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(const SnackBar(content: Text('Printer disconnected')));
  // }
}
