import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create/vocation_card.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/service/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateChart extends StatefulWidget {
  const CreateChart({super.key});

  @override
  State<CreateChart> createState() => _CreateChartState();
}

class _CreateChartState extends State<CreateChart> {

  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  // handling vocation selection
  Vocation selectedVocation = Vocation.junkie;

  void updateVocation(Vocation vocation) {
    setState(() {
      selectedVocation = vocation;
    });
  }

  // sumit handler
  void handleSubmit() {
    if(_nameController.text.trim().isEmpty){

      showDialog(context: context, builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.secondaryAccent,
          surfaceTintColor: AppColors.secondaryAccent,
          title: const StyledHeading('Missing character name'),
          content: const StyledText('Every good RPG character needs a great name...'),
          actions: [
            StyledButton(
              onPressed: () => Navigator.pop(ctx), 
              child: const StyledHeading('Close')
            )
          ],
        );
      });
      return;
    }
    if(_sloganController.text.trim().isEmpty){
      
      showDialog(context: context, builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.secondaryAccent,
          surfaceTintColor: AppColors.secondaryAccent,
          title: const StyledHeading('Missing character slogan'),
          content: const StyledText('Every good RPG character needs a great slogan...'),
          actions: [
            StyledButton(
              onPressed: () => Navigator.pop(ctx), 
              child: const StyledHeading('Close')
            )
          ],
        );
      });
      return;
    }
    
    Provider.of<CharacterStore>(context, listen: false)
    .characters.add(Character(
      name: _nameController.text.trim(), 
      slogan: _sloganController.text.trim(), 
      id: uuid.v4(), 
      vocation: selectedVocation
    ));

    Navigator.push(context, MaterialPageRoute(
      builder: (cxt) => const Home(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Create Character'
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),
              const Center(
                child: StyledHeading('Welcome, new player'),
              ),
              const Center(
                child: StyledText('Create a name and slogan for your character'),
              ),
              const SizedBox(height: 30),
          
              // input for name and slogan
              TextField(
                controller: _nameController,
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  label: StyledText('Character name'),
                ),
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _sloganController,
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.chat),
                  label: StyledText('Character slogan'),
                ),
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),
              const Center(
                child: StyledHeading('Choose a vocation'),
              ),
              const Center(
                child: StyledText('This determines your available skills'),
              ),
              const SizedBox(height: 30),
              // cards
              VocationCard(
                vocation: Vocation.junkie,
                onTap: updateVocation,
                selected: selectedVocation == Vocation.junkie,
              ),
              VocationCard(
                vocation: Vocation.ninja,
                onTap: updateVocation,
                selected: selectedVocation == Vocation.ninja,
              ),
              VocationCard(
                vocation: Vocation.wizard,
                onTap: updateVocation,
                selected: selectedVocation == Vocation.wizard,
              ),
              VocationCard(
                vocation: Vocation.raider,
                onTap: updateVocation,
                selected: selectedVocation == Vocation.raider,
              ),

              // good luck message
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),
              const Center(
                child: StyledHeading('Good luck'),
              ),
              const Center(
                child: StyledText('Add enjoy the journey ahead...'),
              ),
              const SizedBox(height: 30),
              Center(
                child: StyledButton(
                  onPressed: handleSubmit, 
                  child: const StyledHeading('Create Character')
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}