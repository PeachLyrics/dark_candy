import 'package:flutter/material.dart';

class PerfilWidget extends StatelessWidget{

  final String nome;
  final String codigo;
  final String foto;

  PerfilWidget(this.foto,this.nome,this.codigo);

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.indigo[300],
        border: Border.all(
          color: Colors.indigo[600],
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10)
        ),
      ),
      child: Column(
        children: [
          Image.asset(foto),
          Text(nome),
          Text(codigo),
        ],
      )
    );
  }
}