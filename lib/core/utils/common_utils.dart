import 'dart:io';

Future<String?> getMyLocalIP() async {
  for (var interface in await NetworkInterface.list()) {
    for (var addr in interface.addresses) {
      if (addr.type == InternetAddressType.IPv4 &&
          !addr.isLoopback) {
        return addr.address;
      }
    }
  }
  return null;
}

