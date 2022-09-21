import 'package:epilepsy_prevention/page_test.dart';
import 'package:flutter/material.dart';
import 'package:epilepsy_prevention/memory.dart';
import 'package:epilepsy_prevention/page_memory.dart';
import 'package:epilepsy_prevention/notifications.dart';

class PageMemories extends StatefulWidget
{
  const PageMemories({Key? key}) : super(key: key);

  @override
  State<PageMemories> createState() => PageMemoriesState();
}

class PageMemoriesState extends State<PageMemories>
{
  List<Widget> m_memoryWidgets = [];

  Widget build(BuildContext context)
  {
    Notifications.m_selectedNotificationSubject.stream.listen((String? memoryKey) async {
      if(memoryKey != null) {
        var database = Database();
        int? keyValue = int.tryParse(memoryKey);
        if(keyValue != null)
        {
          Memory? mem = database.getMemoryWithId(keyValue);
          if (mem != null) {
            Notifications.m_selectedNotificationSubject.add(null);
            Navigator.push(context, MaterialPageRoute(builder: (context) => PageTest(mem)));
          }
        }
      }
    });

    m_memoryWidgets = getMemoryWidgets(context);

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>
        [
        const Spacer(),

        Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
          TextButton(onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => PageMemory(Memory())));
            setState(() {
              m_memoryWidgets = getMemoryWidgets(context);
            });
          }, child: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("Add new entry")
            ))
        ]
        ),

        const Spacer(),

        SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * 0.8, child: ListView(shrinkWrap: true, scrollDirection: Axis.vertical, children: m_memoryWidgets)),

        const Spacer()
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
        widgets.add(Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => PageMemory(memory)));
              setState(() {
                m_memoryWidgets = getMemoryWidgets(context);
              });
            }, child: Text(memory.m_question != "" ? memory.m_question : "Error")),

            TextButton(onPressed: () async {
               Navigator.push(context, MaterialPageRoute(builder: (context) => PageTest(memory)));
            }, child: const Text("Test"))
          ],
        ));
      }
    }
    return widgets;
  }
}