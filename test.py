import ev3dev2.motor as motor
import time

motor_a=motor.LargeMotor(motor.OUTPUT_B)
voltages=[-100,-80,-60,-40,-20,0,20,40,60,80,100]

try:
    for vol in voltages:
        time.sleep(1)
        timeStart=time.time()
        startPos=motor_a.position
        name='data-'+str(vol)
        with open(name,'w') as f:
            while True:
                current_time=time.time()-timeStart
                current_speed=motor_a.speed
                current_pos=motor_a.position - startPos
                motor_a.run_direct(duty_cycle_sp=vol)
                f.write('{};{};{}\n'.format(current_time,current_pos,current_speed))
                if current_time>1:
                    motor_a.run_direct(duty_cycle_sp=0)
                    break

except Exception as e:
    raise e

finally:
    motor_a.stop(stop_action='brake')