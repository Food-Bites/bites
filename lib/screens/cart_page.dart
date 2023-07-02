import 'package:android_intent/android_intent.dart';
import 'package:bites/data/cart.dart';
import 'package:bites/data/purchasable_foods.dart';
import 'package:bites/widget/helper_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';

/// The [CartPage] class is the page that displays the cart.
/// {@category Screens}
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  DateTime selectedDate = DateTime.now();
  String note = '';
  String contact = '';
  PurchasableFood food = PurchasableFood(
    id: "",
    name: "",
    image: "",
    description: "",
    price: 0.00,
    owner: "",
  );

  void _addToCalendar(PurchasableFood foodItem) {
    // add to calendar
    final intent = AndroidIntent(
      action: 'android.intent.action.INSERT',
      data: 'content://com.android.calendar/events',
      arguments: {
        'title': 'Pick Up the order from Bites',
        'description':
            'You have ordered ${foodItem.name} from Bites. Remember to pick it up at ${selectedDate.hour}:${selectedDate.minute} on ${selectedDate.day}/${selectedDate.month}/${selectedDate.year} at ${foodItem.owner}',
        'eventLocation': 'Bites',
        'beginTime': selectedDate.millisecondsSinceEpoch,
        'endTime': selectedDate.millisecondsSinceEpoch + 3600000,
        'allDay': false,
      },
    );
    intent.launch();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        TextField(
                          onChanged: (val) => setState(() {
                            note = val;
                          }),
                          decoration: const InputDecoration(
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
                              '2. Add your contact details',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          onChanged: (val) => setState(() {
                            contact = val;
                          }),
                          decoration: const InputDecoration(
                            labelText: 'Phone Number or Email',
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
                              '3. Choose the pick up time',
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
                            selectedDate = DateTime.parse(val);
                          }),
                          validator: (val) {
                            // date time choosen must be in the future
                            if (DateTime.parse(val!).isBefore(DateTime.now())) {
                              return 'Please enter a valid date';
                            }
                            return null;
                          },
                          onSaved: (val) => setState(() {
                            selectedDate = DateTime.parse(val!);
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
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '4. Check your order',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Consumer<Cart>(
                builder: (context, cart, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cart.count,
                    itemBuilder: (context, index) {
                      final foodItem = cart.items[index];
                      return Card(
                        child: ListTile(
                          leading: Hero(
                            tag: foodItem.name,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                child: Image.network(foodItem.image)),
                          ),
                          title: Text(foodItem.name),
                          subtitle: Text('€ ${foodItem.price}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cart.remove(foodItem);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '5. Complete your order',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              HelperText(
                icon: IconType.heroIcons(HeroIcons.informationCircle),
                text: 'Your calendar will open to add a reminder in it.',
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                  onPressed: () {
                    if (note.isEmpty || contact.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all the fields'),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }
                    if (selectedDate.isBefore(DateTime.now())) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please choose a valid date'),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }
                    if (selectedDate.isAtSameMomentAs(DateTime.now())) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Be sure to choose a valid date'),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }
                    food =
                        Provider.of<Cart>(context, listen: false).items.first;
                    Provider.of<Cart>(context, listen: false).clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Order placed successfully.'),
                        duration: Duration(seconds: 5),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    _addToCalendar(
                      food,
                    );
                    Navigator.of(context).pop();
                  },
                  icon: const HeroIcon(HeroIcons.check),
                  label: const Text('Order')),
            ],
          ),
        ),
      ),
    );
  }
}
