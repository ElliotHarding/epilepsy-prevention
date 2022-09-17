import 'package:flutter/material.dart';
import 'package:epilepsy_prevention/Memory.dart';
import 'package:epilepsy_prevention/page_memory.dart';

class PageMemories extends StatelessWidget
{
  PageMemories({super.key});

  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Column(children: <Widget>
        [
        const Spacer(),

        ListView(shrinkWrap: true, scrollDirection: Axis.vertical, children: getMemoryWidgets(context))
        ]
      )
    );
   }

  List<Widget> getMemoryWidgets(BuildContext context)
  {
    List<Widget> widgets = <Widget>[];

    var box = Database().getMemoryBox();
    if(box != null)
    {
      for(Memory memory in box.values)
      {
        widgets.add(Row(
          children: [
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PageMemory(memory)));
            }, child: Text(memory.m_question))
          ],
        ));
      }
    }
    return widgets;
  }
}