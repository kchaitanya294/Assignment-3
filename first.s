
	  AREA appcode,CODE,READONLY
	 EXPORT __main
	 IMPORT printMsg
	 IMPORT printMsg2p
	 IMPORT printMsg4p
		 
    ENTRY 

__main  FUNCTION
	MOV R0,#2; ;select the choice :- 1 -> AND,  2-> OR, 3-> NOT, 4 -> XOR, 5 -> XNOR, 6 -> NAND, 7 -> NOR   
		  MOV R1,#1; Give input1
		  MOV R2,#1; Give input2
		  MOV R3,#1; Give input3
		  
		  ; Below code is Switch-case equivalent
		  
		  CMP R0,#1			
		  BEQ ANDG		;enters AND gate if choice is 1
		  
		  CMP R0,#2
		  BEQ ORG		;enters OR gate if choice is 2
		  
		  CMP R0,#3
		  BEQ NOTG		;enters NOT gate if choice is 3
		 
		  CMP R0,#4
		  BEQ XORG		;enters XOR gate if choice is 4
		 
		  CMP R0,#5
		  BEQ XNORG		;enters XNOR gate if choice is 5
		  
		  CMP R0,#6
		  BEQ NANDG		;enters NAND gate if choice is 6
		  
		  CMP R0,#7
		  BEQ NORG		;enters NOR gate if choice is 7
		  

ANDG	  VLDR.F32 S1,= -0.1 	;S1 contains Weight1(W1)
		  VLDR.F32 S2,= 0.2		;S2 contains Weight2(W2)
		  VLDR.F32 S3,= 0.2		;S3 contains Weight3(W3)
		  VLDR.F32 S4,= -0.2	;S4 contains Bias
		  BL SIGMOID			;Call the Sigmoid function
		  VLDR.F S9,=0.51		;loading the threshold value
		  VCMP.F32 S3,S9		;Comparing the real output with thresold value to decide the output is 0 or 1
		  VLDRGE.F S1,=1		;making the decision
		  VLDRLT.F S1,=0		;making the decision
		  VCVT.S32.F32 S1,S1	;converting floating point number to integer
		  VMOV.F32 R0,S1		;Shifting the value to R0 for printing output.
		  BL printMsg			;Printing the output value
		  B stop				
		  
ORG	      VLDR.F32 S1,= -0.1	;Assigning specific weights
		  VLDR.F32 S2,= 0.7
		  VLDR.F32 S3,= 0.7
		  VLDR.F32 S4,= -0.1
		  BL SIGMOID
		  VLDR.F S9,=0.45		;loading the threshold value
		  VCMP.F32 S3,S9		;Comparing the real output with thresold value to decide the output is 0 or 1
		  VLDRGE.F S1,=1		;making the decision
		  VLDRLT.F S1,=0		;making the decision
		  VCVT.S32.F32 S1,S1	;converting floating point number to integer
		  VMOV.F32 R0,S1		;Shifting the value to R0 for printing output.
		  BL printMsg			;Printing the output value
		  B stop
	
NOTG	  VLDR.F32 S1,= 0.5		;Assigning specific weights
		  VLDR.F32 S2,= 0
		  VLDR.F32 S3,= 0
		  VLDR.F32 S4,= 0.1
		  BL SIGMOID
		  VLDR.F S9,=0.52		;loading the threshold value
		  VCMP.F32 S3,S9		;Comparing the real output with thresold value to decide the output is 0 or 1
		  VLDRGE.F S1,=1		;making the decision
		  VLDRLT.F S1,=0		;making the decision
		  VCVT.S32.F32 S1,S1	;converting floating point number to integer
		  VMOV.F32 R0,S1		;Shifting the value to R0 for printing output.
		  BL printMsg			;Printing the output value
		  B stop
		  
XORG	  VLDR.F32 S1,= -5		;Assigning specific weights
		  VLDR.F32 S2,= 20
		  VLDR.F32 S3,= 10
		  VLDR.F32 S4,= 1
		  BL SIGMOID
		  ;BL printMsg   Don't know the threshold value so not printing 
		  B stop
		  
XNORG	  VLDR.F32 S1,= -5		;Assigning specific weights
		  VLDR.F32 S2,= 20
		  VLDR.F32 S3,= 10
		  VLDR.F32 S4,= 1
		  BL SIGMOID			;This is calling thee first layer of Neural network which contains 3 neurons
		  VMOV.F32 S10,S3;		;I took same weights for three neurons as weights are not specified.
		  VMOV.F32 S11,S3;		;Since the weights are same for three neurons I direclty took the output of  
		  VMOV.F32 S12,S3;		;one neuron and considered it as the outputs of other first layer neurons.
		  VLDR.F32 S13,=1;
		  BL HIDDENLAYER		;Now S10,S11,S12,S13 becomes the inputs to second layer neuron.Calling the second euron layer here.
		  ;BL printMsg			;Don't know the threshold value so not printing
		  B stop
		  
NANDG	  VLDR.F32 S1,= 0.6		;Assigning specific weights
		  VLDR.F32 S2,= -0.8
		  VLDR.F32 S3,= -0.8
		  VLDR.F32 S4,= 0.3
		  BL SIGMOID
		  BL printMsg			;Printing the output value
		  B stop

NORG	  VLDR.F32 S1,= 0.5		;Assigning specific weights
		  VLDR.F32 S2,= -0.7
		  VLDR.F32 S3,= -0.7
		  VLDR.F32 S4,= 0.1
		  BL SIGMOID
		  VLDR.F S9,=0.52		;loading the threshold value
		  VCMP.F32 S3,S9		;Comparing the real output with thresold value to decide the output is 0 or 1
		  VLDRGE.F S1,=1		;making the decision
		  VLDRLT.F S1,=0		;making the decision
		  VCVT.S32.F32 S1,S1	;converting floating point number to integer
		  VMOV.F32 R0,S1		;Shifting the value to R0 for printing output.
		  BL printMsg			;Printing the output value
		  B stop
		  
		  
SIGMOID   VMOV.F S6,S1 ; moving W1 to S6
		  VMOV.F S7,S2 ; moving W2 to S7
		  VMOV.F S8,S3 ; moving W3 to S8
		  VMOV.F S9,S4 ; moving bias to S9 
		  VMOV.F S10,R1;
		  VCVT.F32.S32 S10,S10 ;coverting integer input1 to floating number 
		  VMOV.F S11,R2;
		  VCVT.F32.S32 S11,S11 ;coverting integer input2 to floating number 
		  VMOV.F S12,R3;
		  VCVT.F32.S32 S12,S12 ;coverting integer input3 to floating number 
		  
		  
HIDDENLAYER		  VMUL.F S6,S6,S10     ;W1.input1
				  VMUL.F S7,S7,S11		;W2.input2
		          VMUL.F S8,S8,S12		;W3.input3
		          VADD.F S6,S6,S7;		;W1.input1 + W2.input2
		          VADD.F S6,S6,S8;		;W1.input1 + W2.input2 + W3.input3
		          VADD.F S0,S6,S9;		;W1.input1 + W2.input2 + W3.input3 + bias = X
		          MOV R1,#10                      ;NUMBER OF TERMS TO TAKE IN EXPONENTIAL EXPANSION 
		          VMOV.F S4,#1.0;
		          VMOV.F S3,#1.0                  ;this contains E^X value
		          VMOV.F S2,#1.0             
		          VMOV.F S1,#1.0                 
		          VMOV.F S5,#1.0
		          VNMUL.F32 S0,S0,S5			  ;negation of X
				  
		;Caluclation of E^(-X)
		
LOOP1	  VMUL.F32 S1,S1,S0               ;S1=S1* -X
		  VDIV.F32 S1,S1,S2               ;S1=S1/N
		  VADD.F32 S3,S3,S1               ;S3=S3+X^N/N!
		  VADD.F32 S2,S2,S4               ;N++
		  SUB R1,R1,#1                    
		  CMP R1,#0
		  BNE LOOP1  		  			  ;BRANCH TO LOOP 
		
		  VADD.F32 S3,S3,S5				  ;1+E^(-X)
		  VDIV.F32 S3,S5,S3				  ;1/(1+E^(-X))
		  BX lr
stop    B stop                          ; stop program
     ENDFUNC
	 END
		 
		 
;AND GATE RESULTS
;  INPUTS       EXPECTED OUTPUT         ACTUAL OUTPUT
;	000				0						0.450166
;	001				0						0.5
;	010				0						0.5
;	011				0						0.549
;	100				0						0.425
;	101				0						0.475
;	110				0						0.475
;	111				1						0.52497
;Observation: Not able to select a threshold Value to decide the output is 0 or 1 because of the cases 111 and 011
;But still considered a threshold value to make the 0 or 1 for printing output.

;OR GATE RESULTS
;  INPUTS       EXPECTED OUTPUT         ACTUAL OUTPUT
;	000				0						0.475
;	001				1						0.645
;	010				1						0.645
;	011				1						0.785
;	100				1						0.4501
;	101				1						0.622
;	110				1						0.622
;	111				1						0.768
;Observation: Not able to select a threshold Value to decide the output is 0 or 1 because of the cases 100 and 000
;But still considered a threshold value to make the 0 or 1 for printing output.

;NAND GATE RESULTS
;  INPUTS       EXPECTED OUTPUT         ACTUAL OUTPUT
;	000				1						0.574443
;	001				1						0.377541
;	010				1						0.377541
;	011				1						0.214165
;	100				1						0.71095
;	101				1						0.524979
;	110				1						0.544979
;	111				0						0.331812
;Observation: Not able to select a threshold Value to decide the output is 0 or 1 because of the cases 011 and 111
;But still considered a threshold value to make the 0 or 1 for printing output.

;NOR GATE RESULTS
;  INPUTS       EXPECTED OUTPUT         ACTUAL OUTPUT
;	000				1						0.524979
;	001				0						0.354344
;	010				0						0.354344
;	011				0						0.214165
;	100				0						0.645656
;	101				0						0.475021
;	110				0						0.475021
;	111				0						0.310026
;Observation: Not able to select a threshold Value to decide the output is 0 or 1 because of the cases 100 and 000
;But still considered a threshold value to make the 0 or 1 for printing output.

;NOT GATE RESULTS
;  INPUTS       EXPECTED OUTPUT         ACTUAL OUTPUT
;	0				1						0.524979
;	1				0						0.645656
;Observation: Not able to select a threshold Value to decide the output is 0 or 1 because of the cases 0 and 1
;But still considered a threshold value to make the 0 or 1 for printing output.

;XOR GATE RESULTS
;  INPUTS       EXPECTED OUTPUT         ACTUAL OUTPUT
;	000				0						0.731059
;	001				1						0.000273385
;	010				1						3.24648e-007
;	011				0						5.8917e-009
;	100				1						0.0180365
;	101				0						0.142741
;	110				0						5.44632e-006
;	111				1						3.58787e-008
;Observation: Not able to select a threshold Value to decide the output is 0 or 1 because of the cases 001 and 000

;XNOR GATE RESULTS
;  INPUTS       EXPECTED OUTPUT         ACTUAL OUTPUT
;	000				0						0.622459
;	001				1						0.623743
;	010				1						0.622462
;	011				0						0.622459
;	100				1						0.601044
;	101				0						0.932683
;	110				0						0.622504
;	111				1						0.62246
;Observation: Not able to select a threshold Value to decide the output is 0 or 1 because of the cases 101 and remaining cases



