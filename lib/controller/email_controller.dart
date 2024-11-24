import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailController {

  Future<void> sendEmailWithAttachment(String pdfPath) async {
    final Email email = Email(
      body: 'Este es el reporte generado.',
      subject: 'Reporte Diario',
      recipients: ['kevinchi78@gmail.com'], // Cambia con la dirección del destinatario
      attachmentPaths: [pdfPath], // Ruta del archivo PDF
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      print('Correo enviado con éxito');
    } catch (e) {
      print('Error al enviar el correo: $e');
    }
  }
}
