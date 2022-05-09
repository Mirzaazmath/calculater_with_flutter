import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  bool mode=true;
  dynamic displaytxt = 20;
  //Button Widget
  Widget calcbutton(String btntxt,Color btncolor,Color txtcolor){
    return  Container(

      child: RaisedButton(

        onPressed: (){
          calculation(btntxt);
        },
        child: Text('$btntxt',
          style: TextStyle(
            fontSize: 20,
            color: txtcolor,
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(25),
        splashColor:Colors.white,
      ),

    );
  }
  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor:mode? Colors.black : Colors.grey[150],
      appBar: AppBar(
        title: Text('Calculator',style: TextStyle(color: mode?Colors.white:Colors.black ),),
        backgroundColor:mode? Colors.black : Colors.white,
        actions: [CupertinoSwitch(



      // thumb colors
      activeColor: Colors.grey[500],
        trackColor: Colors.grey[900],

        value: mode,
        onChanged: (value) => setState(() => this.mode = value),
      ),


        ],
      ),
      body:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(

                  child:  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:
                    Text('$text',overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: mode?Colors.white: Colors.black,
                        fontSize: 70,
                      ),
                    ),
                  ))

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Expanded(child: calcbutton('AC',Colors.grey,Colors.black),),
               Expanded(child: calcbutton('+/-',Colors.grey,Colors.black),),
                Expanded(child: calcbutton('%',Colors.grey,Colors.black),),
                Expanded(child: calcbutton('/',Colors.amber.shade700,mode?Colors.white:Colors.black),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(child:  calcbutton('7',mode?Colors.grey.shade800:Colors.black,Colors.white),),

                Expanded(child: calcbutton('8',mode?Colors.grey.shade800:Colors.black,Colors.white),),
               Expanded(child:  calcbutton('9',mode?Colors.grey.shade800:Colors.black,Colors.white),),
               Expanded(child: calcbutton('x',Colors.amber.shade700,mode?Colors.white:Colors.black ),) ,
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               Expanded(child: calcbutton('4',mode?Colors.grey.shade800:Colors.black,Colors.white),),
               Expanded(child: calcbutton('5',mode?Colors.grey.shade800:Colors.black,Colors.white),) ,
                Expanded(child: calcbutton('6',mode?Colors.grey.shade800:Colors.black,Colors.white),),
               Expanded(child:  calcbutton('-',Colors.amber.shade700,mode?Colors.white:Colors.black),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(child: calcbutton('1',mode?Colors.grey.shade800:Colors.black,Colors.white),),
               Expanded(child: calcbutton('2',mode?Colors.grey.shade800:Colors.black,Colors.white),),
               Expanded(child: calcbutton('3',mode?Colors.grey.shade800:Colors.black,Colors.white),) ,
               Expanded(child: calcbutton('+',Colors.amber.shade700,mode?Colors.white:Colors.black),) ,
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //this is button Zero
                Expanded(child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: (){
                    calculation('0');
                  },
                  shape: StadiumBorder(),
                  child: Text('0',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white),
                  ),
                  color:mode?Colors.grey.shade800:Colors.black,
                  splashColor: Colors.white,
                ),),
                Expanded(child: calcbutton('.',mode?Colors.grey.shade800:Colors.black,Colors.white),),
               Expanded(child: calcbutton('=',Colors.amber.shade700,mode?Colors.white:Colors.black),) ,
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

}
