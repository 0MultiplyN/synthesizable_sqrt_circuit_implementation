//------------------------------------------------------//
//- VLSI 2023                                           //
//-                                                     //
//- Exercise: Design a square root circuit              //
//------------------------------------------------------//
// Square Root

module SQRT(
	RST,
	CLK,
	IN_VALID,
	IN,
	OUT_VALID,
	OUT
);

input CLK;
input RST;
input [15:0] IN;
input IN_VALID;
output [11:0] OUT;
output OUT_VALID;

reg ovalid ;
reg [11:0] ans ;
reg [25:0] result ;
reg [25:0] indata ;  
reg [25:0] lhd ;
reg [25:0] mid ; 
reg [25:0] rhd ;  
reg [2:0] state ; 
reg [3:0] cnt ; 

assign OUT_VALID = ovalid  ;  
assign OUT = ans ;  



// Write your synthesizable code here



always@( posedge CLK or posedge RST )
begin
    if( RST == 1 )
    begin
        ovalid <= 0 ;
    end
    else 
    begin
    case(state)
    3'd0:
    begin
        ovalid <= 0 ;
    end
    3'd2:
    begin
        ovalid <= 1 ; 
    end
    endcase
    end
end


always@( posedge CLK or posedge RST )
begin
    if( RST == 1 )
    begin
        ans <= 0 ;
    end
    else 
    begin
    case(state)
    3'd2:
    begin
        ans <= result[12:1] + result[0] ; 
    end
    endcase
    end
end

always@( posedge CLK or posedge RST )
begin
    if( RST == 1 )
    begin
        state <= 0 ;  
    end
    else 
    begin
    case(state)
    3'd0:
    begin
        if( IN_VALID == 1 )
	    begin
		    state <= 1 ;  
	    end
        else
        begin
            state <= 0 ; 
        end
    end
    3'd1:
    begin
        if( cnt == 0 )
        begin
            state <= 2 ;
        end
        else
        begin
            state <= 1 ;
        end
    end
    3'd2:
    begin
        state <= 0 ;
    end
    endcase
    end
end

always@( posedge CLK )
begin
    if( state == 0 )
    begin
       
        if( IN_VALID == 1 )
        begin
            indata <= IN << 10 ; 
        end
        
    end
end

always@( posedge CLK )
begin
    if( state == 1 )
    begin
        if( cnt == 0 )
        begin
            if( lhd >= mid )
            begin 
                result <= rhd | 1 ;
            end
            else
            begin
                result <= rhd ; 
            end
        end
    end
end


always@( posedge CLK or posedge RST )
begin
    if( RST == 1 )
    begin
        cnt <= 12 ;
    end
    else 
    begin
    case(state)
    3'd0:
    begin
        cnt <= 12 ; 
    end
    3'd1:
    begin
        cnt <= cnt - 1 ; 
    end
    endcase
    end
end

always@( posedge CLK or posedge RST )
begin
    if( RST == 1 )
    begin
        lhd <= 0 ;
    end
    else 
    begin
    case(state)
    3'd0:
    begin
        if( IN_VALID == 1 )
	    begin
		    lhd <= IN << 10 ; 
	    end
    end
    3'd1:
    begin
	if( lhd >= mid )
        begin 
            lhd <= lhd - mid ;
        end
    end
    endcase
    end
end

always@( posedge CLK or posedge RST )
begin
	if( RST == 1 )
	begin	 
        mid <= 16777216 ;  
	end
	else
	begin
	case(state)
	3'd0:		
	begin
	    if( IN_VALID == 1 )
	    begin
            mid <= 16777216 ; 
	    end
	end
    3'd1:
    begin
        if( cnt != 0 )
        begin
            if( lhd >= mid )
            begin 
                mid <= ( ( rhd | ( 1 << cnt ) ) << cnt ) | ( 1 << ( cnt + cnt - 2 ) ); 
            end
            else
            begin
                mid <= ( rhd  << cnt ) | ( 1 << ( cnt + cnt - 2 ) ) ; 
            end
        end
    end
	endcase
	end
end

always@( posedge CLK or posedge RST )
begin
	if( RST == 1 )
	begin	
        rhd <= 0 ; 
	end
	else
	begin
	case(state)
	3'd0:		
	begin
	    if( IN_VALID == 1 )
	    begin
            rhd <= 0 ; 
	    end
	end
    3'd1:
    begin
        if( cnt != 0 )
        begin
           if( lhd >= mid )
            begin 
                rhd <= rhd | ( 1 << cnt ) ;
            end
        end
    end
	endcase
	end
end


 
endmodule