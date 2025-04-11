import 'package:flutter/material.dart';
import 'package:meditech/core/constants/colors.dart';

class MessageInput extends StatefulWidget {
  final Function(String) onSendMessage;
  final bool isAttachmentOptionsVisible;
  final VoidCallback toggleAttachmentOptions;

  const MessageInput({
    required this.onSendMessage,
    required this.isAttachmentOptionsVisible,
    required this.toggleAttachmentOptions,
  });

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      widget.onSendMessage(_messageController.text);
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Attachment options - only visible when toggled
        if (widget.isAttachmentOptionsVisible)
          Container(
            height: 100, // Fixed height
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildAttachmentOption(Icons.photo, Colors.purple, 'Gallery'),
                SizedBox(width: 16),
                _buildAttachmentOption(Icons.camera_alt, Colors.red, 'Camera'),
                SizedBox(width: 16),
                _buildAttachmentOption(Icons.file_copy, Colors.blue, 'Document'),
                SizedBox(width: 16),
                _buildAttachmentOption(Icons.location_on, Colors.green, 'Location'),
                SizedBox(width: 16),
                _buildAttachmentOption(Icons.mic, Colors.orange, 'Audio'),
                SizedBox(width: 16),
                _buildAttachmentOption(Icons.contact_page, Colors.teal, 'Contact'),
              ],
            ),
          ),
        // Message input bar
        Container(
          color: AppColors.white,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  widget.isAttachmentOptionsVisible ? Icons.close : Icons.attach_file,
                  color: AppColors.primaryColor,
                ),
                onPressed: widget.toggleAttachmentOptions,
              ),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "اكتب رسالتك هنا",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentOption(IconData icon, Color color, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ],
    );
  }
}