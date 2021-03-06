import 'package:brew_crew/authenticate/authentication_service.dart';
import 'package:brew_crew/model/entry.dart';
import 'package:brew_crew/providers/entry_provider.dart';
import 'package:brew_crew/screens/entry.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Home extends StatelessWidget {
  //bool loading = true;

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Brew Crew", style: TextStyle(fontSize: 25),),
        actions: [
          RaisedButton(
            onPressed: () => context.read<AuthenticationService>().signOut(),
            child: Text("SignOut"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Entry>>(
            stream: entryProvider.entries,
            builder: (context, AsyncSnapshot<List<Entry>> snapshot) {
              return ListView.builder(
                  itemCount: snapshot.hasData ? snapshot.data.length : 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing:
                      Icon(Icons.edit, color: Theme.of(context).accentColor),
                      title: Text(formatDate(DateTime.parse(snapshot.data[index].date), [MM, ' ', d, ', ', yyyy]),),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EntryScreen(entry: snapshot.data[index])));
                      },
                    );
                  });
            }),
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EntryScreen()));
          },
        ),
    );
  }
}
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
        ),
      ),
    );
  }
}