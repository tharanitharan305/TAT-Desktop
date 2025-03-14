import 'dart:io';
import 'dart:typed_data';
import 'package:hive/hive.dart';

class FileAdapter extends TypeAdapter<File> {
  @override
  final int typeId = 1;

  @override
  File read(BinaryReader reader) {
    int length = reader.readInt32(); // Read the length of the file
    List<int> byteList = [];
    for (int i = 0; i < length; i++) {
      byteList.add(reader.readByte()); // Read bytes one by one
    }
    Uint8List bytes = Uint8List.fromList(byteList); // Convert to Uint8List
    String filePath = reader.readString(); // Read the file path
    File file = File(filePath);
    file.writeAsBytesSync(bytes); // Write the bytes to the file
    return file;
  }

  @override
  void write(BinaryWriter writer, File obj) {
    Uint8List bytes = obj.readAsBytesSync(); // Read bytes from the file
    writer.writeInt32(bytes.length); // Write the length of the bytes
    bytes.forEach(writer.writeByte); // Write bytes one by one
    writer.writeString(obj.path); // Write the file path
  }
}
