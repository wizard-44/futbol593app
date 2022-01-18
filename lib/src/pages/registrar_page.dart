
/*import 'package:flutter/material.dart';

class RegistrarWidget extends StatefulWidget {
  const RegistrarWidget(
      {Key? key, required this.idmantenimiento, required this.isInicio})
      : super(key: key);
  final String idmantenimiento;
  final bool isInicio;

  @override
  _MantenimientoFormWidgetState createState() =>
      _MantenimientoFormWidgetState();
}

class _MantenimientoFormWidgetState extends State<RegistrarWidget> {
  late Foto _foto;
  File? _imagen;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool _onSaving = false;
  final FotoService _fotoService = FotoService();

  @override
  void initState() {
    super.initState();
    _foto = Foto.created(widget.idmantenimiento);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String etiqueta = widget.isInicio ? "inicial" : "final";
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            width: size.width * .80,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                    width: 2.0, color: Theme.of(context).primaryColorDark)),
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 7.0),
                  child: Column(children: [
                    TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: _foto.observacion,
                        onSaved: (value) {
                          //Este evento se ejecuta cuando el Form ha sido guardado localmente
                          _foto.observacion =
                              value; //Asigna el valor del TextFormField al atributo del modelo
                        },
                        validator: (value) {
                          return _validateObservacion(value!);
                        },
                        decoration:
                            InputDecoration(labelText: "Observación $etiqueta"),
                        maxLength: 255,
                        maxLines: 3),
                    Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Text("Ingresar la fecha",
                            style: Theme.of(context).textTheme.subtitle1)),
                    DatePickerWidget(
                        lastDate: DateTime.now(),
                        looping: false, // default is not looping
                        dateFormat: "dd-MMMM-yyyy",
                        locale: DatePicker.localeFromString('es'),
                        onChange: (DateTime newDate, _) {
                          _foto.fecha = newDate;
                        }),
                    Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Text("Ingresar la imagen $etiqueta",
                            style: Theme.of(context).textTheme.subtitle1)),
                    SizedBox(
                        height: 100.h,
                        width: 150.h,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: _imagen == null
                              ? Image.asset('assets/images/generica.jpg')
                              : Image.file(_imagen!),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                            onPressed: () => _selectImage(ImageSource.camera),
                            icon: const Icon(Icons.camera),
                            label: const Text("Cámara")),
                        ElevatedButton.icon(
                            onPressed: () => _selectImage(ImageSource.gallery),
                            icon: const Icon(Icons.image),
                            label: const Text("Galería")),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: _onSaving
                            ? const CircularProgressIndicator()
                            : Tooltip(
                                message: "Registrar observación $etiqueta",
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      _sendForm();
                                    },
                                    label: const Text("Guardar"),
                                    icon: const Icon(Icons.save)),
                              ))
                  ]),
                )),
          ),
        ],
      ),
    );
  }

  _selectImage(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _imagen = File(pickedFile.path);
    } else {
      _imagen = null;
      //print('No image selected.');
    }
    setState(() {});
  }

  _validateObservacion(String value) {
    if (value.length < 15) {
      return "Debe ingresar al menos 15 caracteres";
    }
    return null; //Cuando se retorna nulo el campo te texto está validado
  }

  _sendForm() async {
    if (!_formKey.currentState!.validate()) return;

    _onSaving = true;
    setState(() {});

    _foto.inicial = widget.isInicio;

    _formKey.currentState!.save(); //Guarda el form localmente

    if (_imagen != null) {
      _foto.url = await _fotoService.uploadImage(_imagen!);
    }

    //Invoca al servicio POST para enviar la Foto
    int estado = await _fotoService.postFoto(_foto);
    if (estado == 201) {
      _formKey.currentState!.reset();
      _onSaving = false;
      Navigator.pop(context);
    }
  }
}

*/