//
// Classe de Biografia - Léo
//
class Biografias{
    String id;
    String biografia;

    Biografias(this.id, this.biografia);

    Biografias.fromJson(Map<String,dynamic> map, String id){
      this.id = id;
      this.biografia = map['Biografia'];
    } 

    Map<String, dynamic> toJson(){
      final Map<String, dynamic> map = Map<String, dynamic>();
      map['id'] = this.id;
      map['Biografia'] = this.biografia;
      return map;
    }
  }