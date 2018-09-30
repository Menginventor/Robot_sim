class dif_robot {
  /*Parameter*/
  float body_width = 15.0/100.0;//15 cm
  float body_length = 15.0/100.0;//15 cm
  float body_mass = 0.5;//250gram
  float J_body = (body_width*body_length)*(body_mass/12.0)*(pow(body_width, 2)+pow(body_length, 2));//estimated body inertia
  float J_wheel = 0.1*J_body;//estimated
  float r_wheel = 3.5/100.0;//whell radius 3.5 cm
  float d_wheel = 12.0/100.0;//wheel distance
  /*Simplified*/
  float J_A = (pow(r_wheel, 2)*body_mass/4.0) + (pow(r_wheel, 2)*J_body/pow(d_wheel, 2)) + J_wheel;
  float J_B = (pow(r_wheel, 2)*body_mass/4.0) + (pow(r_wheel, 2)*J_body/pow(d_wheel, 2));
  float J_C = pow(J_wheel, 2) + (pow(r_wheel, 4)*body_mass*J_body 
    + 2.0*pow(r_wheel, 2)*J_body*J_wheel  )/ pow(d_wheel, 2) + (pow(r_wheel, 2)*body_mass*J_body)/4.0;
  /*----------*/
  /*DC Motor parameter*/
  /*
  Typical operating voltage:   6 V
   Gear ratio:   120:1
   No-load speed @ 6V:   85 rpm
   No-load current @ 6V:   70 mA
   Stall current @ 6V:   800 mA
   Stall torque @ 6V:   75 oz·in 
   n*RPM = n*2pi/60sec rad
   1 ounce inch =  0.0070615518333333 newton meter 
   */
  float motor_Kt = (75.0*0.0070615518333333)/0.8 ;//motor torque conatant Nm / A
  float motor_Kv = 6.0/(85.0*TWO_PI/60.0); //motor BEMF conatantrad/s / voltage
  float motor_Ft = motor_Kt*(70.0/1000.0);//motor friction torque
  float motor_R = 6.0/0.8;//Ohm , motor resistance
  /*Robot state*/
  float[][] pos =  {{0}, {0}, {0}};//x,y,theta
  float[][] vel =  {{0}, {0}, {0}};//x,y,theta
  /*State_space*/
  float[][] phi_dot = {{0.0}, {0.0}};//wheel speed (left,right)

  /*-----------*/
  /*Control input*/
  float[][] E = {{6.0}, {0.0}};//motor voltage(left,right)
  /*--------------*/
  /*External torque*/
  float[][] torque_load = {{0.0}, {0.0}};//motor torque load (left,right)
  float motor_friction(float motor_speed, float motor_torque) {

    if (motor_speed == 0 ) {
      if (abs(motor_torque) < motor_Ft)return -motor_torque;
      else if (motor_torque > 0)return -motor_Ft;
      else return  motor_Ft;//if (motor_torque < 0)
    } else if (motor_speed > 0)return motor_Ft;
    else return  -motor_Ft;//if(motor_speed < 0)

    //return 0;
  }

  float[][] motor_friction(float[][] motor_speed, float[][] motor_torque) {
    float motor_friction_l = motor_friction(motor_speed[0][0], motor_torque[0][0]);
    float motor_friction_r = motor_friction(motor_speed[1][0], motor_torque[1][0]);
    float[][] result = {{motor_friction_l}, {motor_friction_r}};
    return result;
  }

  float [][] state_dot_fc(float[][] _state) {
    //println("state = "+str(_state[0][0]));
    float[][] motor_bemf = mult_vect(_state, motor_Kv);
    println("motor_bemf = "+str(motor_bemf[0][0]));

    float[][] motor_torque = mult_vect(mult_vect(sub_vect(E, motor_bemf), 1.0/motor_R), motor_Kt);
    //println("motor_torque = "+str(motor_torque[0][0]));
    float[][] friction_torque = motor_friction(_state, motor_torque);
    //println("friction_torque = "+str(friction_torque[0][0]));
    //float phi_dot_dot_l = (J_A*(motor_torque[0][0]-friction_torque[0][0])+J_B*(-motor_torque[1][0]+friction_torque[1][0]))/J_C;
    //float phi_dot_dot_r = (J_A*(motor_torque[1][0]-friction_torque[1][0])+J_B*(-motor_torque[0][0]+friction_torque[0][0]))/J_C;
    float phi_dot_dot_l = (J_A*(motor_torque[0][0])+J_B*(-motor_torque[1][0]))/J_C;
    float phi_dot_dot_r = (J_A*(motor_torque[1][0])+J_B*(-motor_torque[0][0]))/J_C;

    float [][] state_dot = {{phi_dot_dot_l}, {phi_dot_dot_r}};
    //float [][]state_dot = mult_vect(motor_torque,1.0/J_wheel);
    return state_dot;
  }
  void state_update() {
    float[][] state_dot = state_dot_fc(phi_dot);//Euler method

    phi_dot = add_vect(phi_dot, mult_vect(state_dot, time_step));
    
    //println("state_dot = "+str(mult_vect(state_dot, time_step)[0][0]));
    
    //println(motor_Ft);
  }
  dif_robot() {
  }
  void draw() {
    pushMatrix();
    translate(30, 20);
    fill(0);  
    rect(0, 0, 50, 50);  // Black rectangle
    popMatrix();
  }
};