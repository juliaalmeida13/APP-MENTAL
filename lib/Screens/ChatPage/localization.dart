import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatL10nBr extends ChatL10n {
  const ChatL10nBr(
      {String attachmentButtonAccessibilityLabel = 'Enviar Media',
      String emptyChatPlaceholder = 'Ainda não há mensagens',
      String fileButtonAccessibilityLabel = 'Arquivo',
      String inputPlaceholder = 'Mensagem',
      String sendButtonAccessibilityLabel = 'Enviar',
      String unreadMessageLabel = 'Não lida'})
      : super(
          unreadMessagesLabel: unreadMessageLabel,
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
        );
}
