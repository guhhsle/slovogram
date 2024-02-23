import 'package:flutter/material.dart';
import 'package:slovogram/functions.dart';

class KeyWord extends StatefulWidget {

  final String word;
  const KeyWord({ Key? key , required this.word}) : super(key: key);

  @override
  _KeyWordState createState() => _KeyWordState();
}

class _KeyWordState extends State<KeyWord> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.width/10:MediaQuery.of(context).size.height/10,
      height: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.width/5.5:MediaQuery.of(context).size.height/7,
      child: Card(
        color: 
          green(widget.word)?Colors.green.shade400
          :yellow(widget.word)?Colors.amber.shade400
          :grey(widget.word)?Colors.grey.shade600
          :Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(left: 2.5, right: 2.5, top: 2.5, bottom: 2.5),
        child: Center(
          child: Text(
            widget.word,
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          )
        ),
      ),
    );
  }
}

class KeyDelete extends StatefulWidget {
  const KeyDelete({ Key? key}) : super(key: key);

  @override
  _KeyDeleteState createState() => _KeyDeleteState();
}

class _KeyDeleteState extends State<KeyDelete> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.width/10:MediaQuery.of(context).size.height/10,
      height: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.width/5.5:MediaQuery.of(context).size.height/5.5,
      child: Card(
        elevation: 1,
        color: Colors.red.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(left: 2.5, right: 2.5, top: 2.5, bottom: 2.5),
        child: const Center(
          child: Icon(
            Icons.keyboard_arrow_left_rounded
          ),
        ),
      ),
    );
  }
}

class KeyEnter extends StatefulWidget {
  const KeyEnter({ Key? key }) : super(key: key);

  @override
  _KeyEnterState createState() => _KeyEnterState();
}

class _KeyEnterState extends State<KeyEnter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.width/10:MediaQuery.of(context).size.height/5.5,
      height: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.width/5.5:MediaQuery.of(context).size.height/10,
      child: Card(
        elevation: 1,
        color: Colors.teal.shade600,   //Colors.cyan.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(left: 2.5, right: 2.5, top: 2.5, bottom: 2.5),
        child: const Center(
          child: Icon(
            //Icons.keyboard_return_rounded
            Icons.keyboard_arrow_right_rounded
          )
        ),
      ),
    );
  }
}