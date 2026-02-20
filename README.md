# MIPS-CA-assignment

# INTRODUCTION 

* This project emulates a MIPS Processor using a python program.
* The program takes the Binary machine code as input and runs certain instructions.
* The Assembly code is converted to Binary Machine code by the MARS Assembler developed by Pete Sanderson and Ken Vollmar
* The next section deals with the dependencies needed

# Dependencies

* The project requires the MARS assembler to run.
* However, The MARS Assembler is downloaded as a JAR(Java ARchive) file.
* Hence, Java JDK is needed

   ## Installing JDK
      * Use the following steps to download JDK (Linux based system - ubuntu)

          ''' bash
              sudo apt update && sudo apt upgrade
              sudo apt install default-jdk
          '''

      * To verify installation use the command

        ''' bash
            java --version
        '''

  ## Installing the MARS Assembler
      * After installing the jdk using the above method used , follow these steps to download MARS MIPS-Assembler
      * Navigate to the official git hub  repo "dpetersanderson.github.io"
      * Clone the repo
      * Then run

        '''bash

          java -jar mars4_5.jar
        '''

      * The assembler is ready to go


# CONTRIBUTORS

* This project has been made by freshman year students of International Institute Information Technology Bangalore (IIITB), India.
* The name of the contributors are as follows :
      * Anamitra Basu
      * Aaronya Chakraborty
      * Aatraya Mukherjee 
  
  
