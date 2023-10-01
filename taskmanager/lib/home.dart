import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/taskdata.dart';

class Home extends StatelessWidget {
  TextEditingController getinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        elevation: 30,
        shape: CircleBorder(eccentricity: 0.9),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 0.5 * height,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text('Add Task '),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        child: TextField(
                          controller: getinput,
                          decoration:
                              InputDecoration(hintText: 'Add Task here....'),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 0.4 * width,
                        child: ElevatedButton(
                            onPressed: () {
                              Provider.of<TaskData>(context, listen: false)
                                  .addtask(getinput.text);

                              getinput.clear();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              elevation: 10,
                              padding: EdgeInsets.all(5),
                            )),
                      )
                    ],
                  ),
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.menu),
                  ),
                  SizedBox(
                    width: 0.05 * width,
                  ),
                  Text(
                    'Task Manager',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 0.05 * height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text(
                      '${Provider.of<TaskData>(context).tasklist.length} tasks',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38),
                  child: IconButton(
                      onPressed: () {
                        Provider.of<TaskData>(context, listen: false)
                            .removetask();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      )),
                )
              ],
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ListView.builder(
                  itemCount: Provider.of<TaskData>(context).tasklist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: ListTile(
                        title: Text(
                          '${Provider.of<TaskData>(context).tasklist[index].taskname}',
                          style: TextStyle(
                              decoration: Provider.of<TaskData>(context)
                                      .tasklist[index]
                                      .ischecked
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        trailing: Checkbox(
                            value: Provider.of<TaskData>(context)
                                .tasklist[index]
                                .ischecked,
                            onChanged: (pressvalue) {
                              if (pressvalue == true) {
                                Provider.of<TaskData>(context, listen: false)
                                    .changecheck(index, true);
                              } else {
                                Provider.of<TaskData>(context, listen: false)
                                    .changecheck(index, false);
                              }
                            }),
                      ),
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
