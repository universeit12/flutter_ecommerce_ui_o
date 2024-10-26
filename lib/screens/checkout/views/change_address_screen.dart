import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/address_model.dart';
import '../add_to_cart_controller.dart';

class ChangeAddressScreen extends StatelessWidget {
  final AddToCartController cartController = Get.find<AddToCartController>();

  ChangeAddressScreen({super.key}) {
    cartController.loadAddressToFields();
  }

  @override
  Widget build(BuildContext context) {
    final _formChangeAddress = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: cartController.address.value == null? Text('Add Address'):Text('Change Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formChangeAddress,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter a address";
                    }
                    return null;
                  },
            
                  controller: cartController.nameController,
                  decoration: const InputDecoration(labelText: 'Address*'),
            
                ),
            
                SizedBox(height: 16,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter a city";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  controller: cartController.cityController,
                  decoration: const InputDecoration(labelText: 'City*'),
                ),
            
                SizedBox(height: 16,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: cartController.zipCodeController,
                  decoration: const InputDecoration(labelText: 'Zip Code'),
                ),
                SizedBox(height: 16,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter a mobile number";
                    }else if(value.length != 11){
                      return "Enter mobile no 01XXXXXXXXX";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: cartController.streetController,
                  decoration: const InputDecoration(labelText: 'Mobile No*'),
                ),
            
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if(!_formChangeAddress.currentState!.validate()){
                      return;
                    }
                    final newAddress = Address(
                      name: cartController.nameController.text,
                      street: cartController.streetController.text,
                      city: cartController.cityController.text,
                      zipCode: cartController.zipCodeController.text,
                    );
                    cartController.saveAddress(newAddress);
                    Get.back(); // Go back to ReviewScreen
                  },
                  child: const Text('Save Address'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
