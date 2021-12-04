import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/domain/pokemon_list_domain.dart';
import 'package:pokedex_flutter/pokemonlist/cubit/events/pokemonlist_event.dart';
import 'package:pokedex_flutter/pokemonlist/cubit/pokemonlist_cubit.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    context.read<PokemonListCubit>().listPokemons();
    const backgroundColor = Color.fromRGBO(144, 238, 144, 0.8);
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              pokemonTitle(),
              textInputSearchPokemon(),
              SizedBox(
                height: 5,
              ),
              lineGradient(),
              BlocBuilder<PokemonListCubit, PokemonListEvent>(
                  builder: (context, state) {
                if (state is PokemonListSucessEvent) {
                  var eventSucces = state as PokemonListSucessEvent;
                  return pokemonList(eventSucces.pokemonList);
                } else {
                  return progressBarList();
                }
              }),
              lineGradient(),
            ]),
      ),
      bottomNavigationBar: navigationBar(context, backgroundColor),
    );
  }

  Container lineGradient() {
    return Container(
        height: 2,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.blue, Colors.green])));
  }

  BottomAppBar navigationBar(
          BuildContext buildContext, Color backgroundColor) =>
      BottomAppBar(
        color: backgroundColor,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 70,
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          buildContext.read<PokemonListCubit>().listPokemons();
                        },
                        child: Image(
                            image:
                                AssetImage('assets/images/pokemon_navbar.png')),
                      ),
                      Text("Pokemons"),
                    ],
                  )),
              Expanded(
                  child: Column(
                children: [
                  Image(image: AssetImage('assets/images/movies_navbar.png')),
                  Text("Movies"),
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Image(image: AssetImage('assets/images/items_navbar.png')),
                  Text("Items"),
                ],
              )),
            ],
          ),
        ),
      );

  Expanded pokemonList(PokemonList pokemonList) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.all(8.0),
              title: Text(pokemonList.results[index].name),
              leading: Image(
                  image: AssetImage('assets/images/examples/bulbasaur.png')),
            );
          },
          itemCount: pokemonList.results.length,
          scrollDirection: Axis.vertical,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Color.fromRGBO(0, 0, 0, 0.12),
            );
          },
        ),
      ),
    );
  }

  Padding pokemonTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: const Text(
          "Pokemon",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Padding textInputSearchPokemon() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.mic),
                fillColor: Color.fromRGBO(0, 0, 0, 0.12),
                filled: true,
                hintText: "Search",
                focusColor: Color.fromRGBO(0, 0, 0, 0.12),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25.0)))),
      );

  Expanded progressBarList() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
          Center(
              child: SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator()))
        ]),
      ),
    );
  }
}