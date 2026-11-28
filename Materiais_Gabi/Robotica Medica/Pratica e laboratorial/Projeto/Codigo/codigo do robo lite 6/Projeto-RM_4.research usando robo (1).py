import math
import time
from xarm.wrapper import XArmAPI

# IP do robô
arm = XArmAPI('192.168.1.176')

#Parametros iniciais da trajetoria
CENTRO = [250, 0] 
RAIO = 80
Z_FIXO = 180
TOLERANCIA = 25.0
ROLL_DOWN, PITCH_DOWN, YAW_DOWN = -180, 0, 0  #Mantem a garra perpendicular ao chão


def inicializar_sistema():
    print("A preparar robô para cirurgia...")
    arm.clean_error()
    arm.motion_enable(True)
    arm.set_mode(0) # modo posição do robo
    arm.set_state(0)
    time.sleep(1)

def fase_1_demonstracao():
    print("Demonstração da trajetória")
    
    # Move para o ponto inicial do círculo
    arm.set_position(x=CENTRO[0] + RAIO, y=CENTRO[1], z=Z_FIXO, 
                     roll=ROLL_DOWN, pitch=PITCH_DOWN, yaw=YAW_DOWN, 
                     speed=50, wait=True)
    
    #Pontos e função para traçar a trajetoria circular
    p1 = [CENTRO[0], CENTRO[1] + RAIO, Z_FIXO, ROLL_DOWN, PITCH_DOWN, YAW_DOWN]
    p2 = [CENTRO[0] - RAIO, CENTRO[1], Z_FIXO, ROLL_DOWN, PITCH_DOWN, YAW_DOWN]
    arm.move_circle(p1, p2, percent=100, speed=40, wait=True)
    print("Demonstração concluída com sucesso.")

def fase_2_assistencia_manual():    
    arm.set_state(4) # Pausa técnica para mudar de modo
    time.sleep(0.5)
    arm.set_mode(2)  # Modo de controlo manual do robo - Gravidade Zero (Braço solto)
    arm.set_state(0)
    print("O médico pode agora conduzir a incisão.")

    try:
        while True:
            code, pos = arm.get_position() #pega a posição atual do robo e coloca em pos
            if code == 0: #code é codigo de retorno e se for igual a 0 quer dizer que correu tudo bem na ligação
                x, y, z = pos[0], pos[1], pos[2]  #da os valores de x, y e z da posição atual do robo guardada na variavel pos
                
                dist_h = math.sqrt((x - CENTRO[0])**2 + (y - CENTRO[1])**2)  #calculo da distancia ao centro
                erro_raio = abs(dist_h - RAIO) #erro/desvio da trajetoria
                erro_z = abs(z - Z_FIXO) #desvio da trajetoria pretentida em z

                #se médico se desviar da trajetória
                if erro_raio > TOLERANCIA or erro_z > TOLERANCIA:
                    print(f"CORREÇÃO da trajetória: Desvio de {max(erro_raio, erro_z):.1f}mm")
                    
                    # Sai de modo manual e corrige a posição
                    arm.set_mode(0)
                    arm.set_state(0)
                    
                    #Calculo do ponto mais próximo da trajetória e devolve robo a essa posição
                    angulo = math.atan2(y - CENTRO[1], x - CENTRO[0])
                    cx = CENTRO[0] + RAIO * math.cos(angulo)
                    cy = CENTRO[1] + RAIO * math.sin(angulo)
                    arm.set_position(x=cx, y=cy, z=Z_FIXO, 
                                     roll=ROLL_DOWN, pitch=PITCH_DOWN, yaw=YAW_DOWN, 
                                     speed=50, wait=True)
                    
                    # Volta a modo manual
                    arm.set_mode(2)
                    arm.set_state(0)
            
            time.sleep(0.1)

    #primir ctrl+c para sair do loop mas executar o finally
    except KeyboardInterrupt:
        print("\nProcedimento finalizado.")

if __name__ == "__main__":
    try:
        inicializar_sistema()
        fase_1_demonstracao()      # Faz o círculo sozinho primeiro
        fase_2_assistencia_manual() # Depois deixa-te mexer com correção
    finally:
        arm.set_mode(0)
        arm.set_state(0)
        arm.set_servo_angle(angle=[0, 0, 0, 0, 0, 0], wait=True)
        arm.disconnect()