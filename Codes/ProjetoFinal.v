module ProjetoFinal ( MotorBomba,MotorMistura, clock, OutArd01, OutArd02);

input clock;
input OutArd01;
input OutArd02;

output reg MotorMistura;
output reg MotorBomba;
							
reg [1:0] estado_atual;
reg [32:0]contadorTeste;
reg Sensor01;
reg Sensor02;

parameter A = 0, B= 1;

always @(*) begin //parte combinacional
	case(estado_atual)
	
	A: begin
		MotorBomba= 0; //motor desligado
		end
	B: begin
		MotorBomba = 1; //motor ligado
		end
	endcase
end
	
always@(OutArd01, OutArd02) begin //parte sequencial
	case(estado_atual)
	
	A: begin //Para o motor desligado, temos as seguintes condicoes
        if(Sensor01 == 0 && Sensor02 == 0)//Não tem copo - Copo vazio
            estado_atual = A;
        if(Sensor01 == 0 && Sensor02 == 1)//Não tem copo - Copo cheio
            estado_atual = A;
        if(Sensor01 == 1 && Sensor02 == 0)//Tem copo - Copo Vazio
             estado_atual = B;
        if(Sensor01 == 1 && Sensor02 == 1)//Tem copo - Copo cheio
            estado_atual = A;
        end
    B: begin //Para o motor ligado, temos as seguintes condicoes
        if(Sensor01 == 0 && Sensor02 == 0)//Não tem copo - Copo vazio
            estado_atual = A;
        if(Sensor01 == 0 && Sensor02 == 1)//Não tem copo - Copo cheio
            estado_atual = A;
        if(Sensor01 == 1 && Sensor02 == 0)//Tem copo - Copo Vazio
            estado_atual = B;
        if(Sensor01 == 1 && Sensor02 == 1)//Tem copo - Copo cheio
            estado_atual = A;
        end
    endcase
end

always @(posedge clock) begin //Controle do sensor 01
	if(OutArd01 == 1)
		Sensor01 = 1;
	else begin
		Sensor01 = 0;
	end
end

			
always@(posedge clock)begin //Controle do sensor 02
	if(OutArd02 == 1)
		Sensor02 = 1;
	else begin
		Sensor02 = 0;
	end
end

always@(posedge clock)begin //Controle de tempo do MotorMistura

	contadorTeste <= contadorTeste + 1;
	MotorMistura = contadorTeste[20];
	
end


endmodule