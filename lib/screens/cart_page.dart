import 'package:bites/data/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '1. Add a note to your order',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Order Notes',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '2. Choose the pick up time',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        DateTimePicker(
                          type: DateTimePickerType.dateTime,
                          dateMask: 'd MMM, yyyy - hh:mm a',
                          initialValue: DateTime.now().toString(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          dateLabelText: 'Date',
                          timeLabelText: 'Hour',
                          onChanged: (val) => setState(() {
                            _selectedDate = DateTime.parse(val);
                          }),
                          validator: (val) {
                            // date time choosen must be in the future
                            if (DateTime.parse(val!).isBefore(DateTime.now())) {
                              return 'Please enter a valid date';
                            }
                            return null;
                          },
                          onSaved: (val) => setState(() {
                            _selectedDate = DateTime.parse(val!);
                          }),
                          use24HourFormat: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Pick up time',
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Consumer<Cart>(
                builder: (context, cart, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cart.count,
                    itemBuilder: (context, index) {
                      final foodItem = cart.items[index];
                      return ListTile(
                        leading: Hero(
                          tag: foodItem.name,
                          child: Image.network(foodItem.image),
                        ),
                        title: Text(foodItem.name),
                        subtitle: Text(foodItem.price.toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            cart.remove(foodItem);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // add a bottom sheet that shows the total price of the cart and a button to clear the cart
      bottomSheet: Consumer<Cart>(
        builder: (context, cart, child) {
          return Container(
            height: 100,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(cart.totalPrice.toString()),
                ElevatedButton(
                  onPressed: () {
                    cart.clear();
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
