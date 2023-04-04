import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Materia App',
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title:const Text('FORMULARIO ALUMNO'),
          backgroundColor: Colors.black,
          ),
      body: const FormCard(),
      )
    );//Scafold
  }
}

class FormCard extends StatefulWidget {
   
  const FormCard({Key? key}) : super(key: key);

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController matriculaController = TextEditingController();
  
GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Form(
        key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*.5,
                child: _inputNombre(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*.5,
                child: _inputApellidos(),
              )
            ],
          ),
          const SizedBox(height: 10,),
          _inputMatricula(),
          const SizedBox(height: 10,),
          _inputTurno(),
          const SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*.5,
                child: _inputAdicional(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*.5,
                child: _inputSexo(),
              )
            ],
          ),
          const SizedBox(height: 10,),
          _inputArea(),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width - 30,
            child: MaterialButton(
            textColor: Colors.grey,
              onPressed: () {
                if (sexo == 'Femenino'){
                  sexoD = 24;
                } else {sexoD = 16;}
              if(formKey.currentState!.validate()) {
                Map<String, dynamic> info = {
                  'NOMBRE':nombreController.text,
                  'APELLIDOS': apellidoController.text,
                  'MATRICULA': matriculaController.text,
                  'TURNO': turno,
                  'ADICIONAL': adicional,
                  'SEXO': sexo,
                  'AREA': areaS
                };
                String jsonstringmap = json.encode(info);
                print(jsonstringmap);
              }
            },
            child: const Text('GUARDAR'))
          )
        ]
      ),
    )
  );
}

  Container _inputNombre() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.indigo),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          controller: nombreController,
          keyboardType: TextInputType.name,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey
            ),
          decoration: const InputDecoration(
            labelText: 'Nombres',
            labelStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.grey,
            //hintText: "NOMBRE",
            border: InputBorder.none
            ),
          validator: (String? value) {
            if(value == null || value.isEmpty) {
              return "Campo requerido";
            }
            return null;
          },
        )
      );
  }

  Container _inputApellidos() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.indigo)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          controller: apellidoController,
          keyboardType: TextInputType.name,
          //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.],
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey
            ),
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.grey,
            labelText: "APELLIDOS",
            border: InputBorder.none
            ),
          validator: (String? value) {
            if(value == null || value.isEmpty) {
              return "Campo requerido";
            }
            return null;
          },
        )
      );
  }

  Container _inputMatricula() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.indigo)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          controller: matriculaController,
          keyboardType: TextInputType.number,
          inputFormatters: /*<TextInputFormatter>*/[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(sexoD),
            FormMatricula(),
            ],
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey
          ),
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.grey,
            labelText: "MATRICULA",
            hintText: '0000 0000 0000 0000',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none
            ),
          validator: (String? value) {
              if(value == null || value.isEmpty) {
                return "Campo requerido";
              }
              return null;
            },
        )
      );
  }
  List<String> turnos = <String>[' ','Matutino', 'Vespertino'];
  String? turno = '';
  Container _inputTurno() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.indigo)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: DropdownButtonFormField(
          items: turnos.map((turn) {
            return DropdownMenuItem(
              value: turn,
              child: Text(turn),
              );
          }).toList(),
          onChanged: (value) => turno = value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey
            ),
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.grey,
            labelText: "TURNO",
            border: InputBorder.none
          ),
          validator: (String? value) {
              if(value == null || value.isEmpty || value == ' ') {
                return "Campo requerido";
              }
              return null;
            },
        )
      );
  }
  List<String> adic = <String>[' ','Artes', 'Sin artes'];
  String? adicional;
  Container _inputAdicional() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.indigo)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: DropdownButtonFormField(
          items: adic.map((add) {
            return DropdownMenuItem(
              value: add,
              child: Text(add),
              );
          }).toList(),
          onChanged: (value) => adicional = value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey
            ),
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.grey,
            labelText: "ADICIONAL",
            border: InputBorder.none
          ),
          validator: (String? value) {
              if(value == null || value.isEmpty || value == ' ') {
                return "Campo requerido";
              }
              return null;
            },
        )
      );
  }
  List<String> sex = <String>[' ','Masculino', 'Femenino'];
  String? sexo;
   int? sexoD = 16;
  Container _inputSexo() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.indigo)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: DropdownButtonFormField(
          items: sex.map((sex) {
            return DropdownMenuItem(
              value: sex,
              child: Text(sex),
              );
          }).toList(),
          onChanged: (value) => sexo = value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey
            ),
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.grey,
            labelText: "SEXO",
            border: InputBorder.none
          ),
          validator: (String? value) {
              if(value == null || value.isEmpty || value == ' ') {
                return "Campo requerido";
              }
              return null;
            },
        )
    );
  
  }
  
  List<String> area = <String>[' ','Area 1', 'Area 2', 'Area 3', 'Area 4'];
  String? areaS;
  Container _inputArea() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.indigo)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: DropdownButtonFormField(
          items: area.map((area) {
            return DropdownMenuItem(
              value: area,
              child: Text(area),
              );
          }).toList(),
          onChanged: (value) => areaS = value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey
            ),
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.grey,
            labelText: "AREA",
            border: InputBorder.none
          ),
          validator: (String? value) {
              if(value == null || value.isEmpty || value == ' ') {
                return "Campo requerido";
              }
              return null;
            },
        )
    );
  }
}

class FormMatricula extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, TextEditingValue newValue) {

      if(newValue.selection.baseOffset == 0) {
        return newValue;
      }

      String inputData = newValue.text;
      StringBuffer buffer = StringBuffer();

  for(var i = 0; i < inputData.length; i++){
    buffer.write(inputData[i]);
    int index = i + 1;

    if(index % 4 == 0 && inputData.length != index){
      buffer.write(" "); //espacio
    }
  }
    return TextEditingValue(text:buffer.toString(),
    selection: TextSelection.collapsed(
      offset: buffer.toString().length,
      ),
    );
  }
}

Alumno alumnoFromJson(String str) => Alumno.fromJson(json.decode(str));

String alumnoToJson(Alumno data) => json.encode(data.toJson());

class Alumno {
    Alumno({
        this.nombre,
        this.apellidos,
        this.matricula,
        this.turno,
        this.adicional,
        this.sexo,
        this.area,
    });

    String? nombre;
    String? apellidos;
    String? matricula;
    String? turno;
    String? adicional;
    String? sexo;
    String? area;

    factory Alumno.fromJson(Map<String, dynamic> json) => Alumno(
        nombre: json["NOMBRE"],
        apellidos: json["APELLIDOS"],
        matricula: json["MATRICULA"],
        turno: json["TURNO"],
        adicional: json["ADICIONAL"],
        sexo: json["SEXO"],
        area: json["AREA"],
    );

    Map<String, dynamic> toJson() => {
        "NOMBRE": nombre,
        "APELLIDOS": apellidos,
        "MATRICULA": matricula,
        "TURNO": turno,
        "ADICIONAL": adicional,
        "SEXO": sexo,
        "AREA": area,
    };
}
