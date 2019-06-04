import 'package:flutter/material.dart';

const String _name = "Hendra Permana";

void main() {
  runApp(FriendlychatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Friendlychat",
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];


  @override
  void dispose() {
    for(ChatMessage cm in _messages){
      cm.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friendlychat"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              reverse: true,
              itemBuilder: (_, index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: this._buildTextComposer(),
          ),
        ],
      ),
      //body: _buildTextComposer(),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: this._controller,
                  onSubmitted: this._handleSubmitted,
                  decoration:
                      InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => this._handleSubmitted(_controller.text)),
              )
            ],
          ),
        ));
  }

  void _handleSubmitted(String text) {
    _controller.clear();
    AnimationController animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 700));
    ChatMessage cm =
        ChatMessage(text: text, animationController: animationController);
    setState(() {
      _messages.insert(0, cm);
    });
    cm.animationController.forward();
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final AnimationController animationController;

  ChatMessage({this.text, this.animationController});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  child: Text(_name[0]),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _name,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(this.text),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
