import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {

  late TextEditingController _commentController;
  late FocusNode _commentFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentController = new TextEditingController();
    _commentFocusNode = new FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentFocusNode.dispose();
    _commentController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _commentController,
                    focusNode: _commentFocusNode,
                    autofocus: false,
                    decoration: new InputDecoration(
                      hintText: "comment",
                      filled: true,
                      contentPadding: EdgeInsets.only(top: 5,left: 10),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                    ),
                    //keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [
                      //FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (val){
                  
                    },
                    maxLines: 1,
                    validator: (value){
                  
                    },
                    onTapOutside: (dd){
                      _commentFocusNode.unfocus();
                    },
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // Only numbers can be entered
                  ),
                ),
                IconButton(
                    onPressed: (){
                      
                    },
                    icon: FaIcon(FontAwesomeIcons.comment)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
