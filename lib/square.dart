import 'package:flutter/material.dart';
import 'package:slovogram/data.dart';
import 'package:slovogram/functions.dart';

class LetterBox extends StatefulWidget {
  final String word;
  final int column, row;
  const LetterBox({ Key? key , required this.word, required this.column, required this.row}) : super(key: key);

  @override
  _LetterBoxState createState() => _LetterBoxState();
}

class _LetterBoxState extends State<LetterBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.width/5.5:MediaQuery.of(context).size.width/12,
      height: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.width/5.5:MediaQuery.of(context).size.width/12,
      child: Card(
        elevation: 0,
        color: 
          (currentTry>widget.column||showWord)&&wantedWord[widget.row]==widget.word?Colors.green.shade400
          :(currentTry>widget.column||showWord)&&wantedWord.contains(widget.word)?Colors.amber.shade400
          :(currentTry>widget.column&&showWord)&&widget.word!=' '?Colors.grey.shade400.withOpacity(0.2)
          :(currentTry>widget.column||showWord)&&widget.word!=' '?Colors.grey.shade400
          :Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            currentTry>widget.column&&!showWord?Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  countSame(widget.word)==0?'':countSame(widget.word)==1?'':countSame(widget.word).toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8
                  ),
                ),
              ),
            ):Container(),
            !showWord||widget.column==5||(widget.column==currentTry-1&&!last)?Center(
              child: Text(
                widget.word,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ):Container()
          ],
        )
      ),
    );
  }
}