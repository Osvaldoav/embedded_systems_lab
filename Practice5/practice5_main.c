#include <bcm2835.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>

#define MODE_READ 0
#define MODE_WRITE 1

#define MAX_LEN 32

typedef char bool;
#define true 1
#define false 0

uint8_t data;
char buf[MAX_LEN];
char wbuf[MAX_LEN];


const char reset_clock_buffer[8] = { 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
// Buffer with date: Mon 12:00 AM 01/01/01
const char initialize_clock_buffer[8] = { 0x00, 0x00, 0x00, 0x52, 0x01, 0x01, 0x01, 0x01 };

const char reset_temp_buffer[8] = { 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
// Buffer with date: Mon 12:00 AM 01/01/01
const char initialize_temp_buffer[8] = { 0x00, 0x00, 0x00, 0x52, 0x01, 0x01, 0x01, 0x01 };

const char *days[7] = {"Mon", "Tue", "Wen", "Thu", "Fri", "Sat", "Sun"};

const uint8_t clock_slave_address = 104; //0x68
const uint8_t temp_slave_address = 0; //0x68
const uint16_t clock_divider = 2500;

bool InitializeBcm2835() {
    if (!bcm2835_init()) {
      printf("bcm2835_init failed. Are you running as root??\n");
      return false;
    }

    if (!bcm2835_i2c_begin()) {
        printf("bcm2835_i2c_begin failed. Are you running as root??\n");
	    return false;
    }
    
    bcm2835_i2c_setClockDivider(clock_divider);

    return true;
}

void InitializeClock() {
    bcm2835_i2c_setSlaveAddress(clock_slave_address);

    // Reset clock
    data = bcm2835_i2c_write(reset_clock_buffer, 8);
    printf("Reset Result = %d\n", data);    

    // Initialize clock
    data = bcm2835_i2c_write(initialize_clock_buffer, 8);
    printf("Initialize Result = %d\n", data);  
}

void InitializeTemp() {
    bcm2835_i2c_setSlaveAddress(temp_slave_address);

    // Reset temp
    data = bcm2835_i2c_write(reset_temp_buffer, 8);
    printf("Reset Result = %d\n", data);    

    // Initialize temp
    data = bcm2835_i2c_write(initialize_temp_buffer, 8);
    printf("Initialize Result = %d\n", data);  
}

void GetDate(){
    // Move to position 0.
    const char point_to[] = {0x00};
    bcm2835_i2c_write(point_to, 1);   
    bcm2835_i2c_read(buf, 7);  
}

void PrintDate() {
    char cSeconds, minutes, hours, day, date, month, year;
    printf("%x/%x/%x %s %x:%x:%x", buf[4] & 0x3F, buf[5] & 0x1F, buf[6], days[(int)(buf[3] & 0x07) - 1], buf[2] & 0x1F, buf[1] & 0x7F, buf[0] & 0x7F);
}

int main(int argc, char **argv) {

    if(!InitializeBcm2835()) {
        return 1;
    }

    InitializeClock();
    //InitializeTemp();

    while(true) {
        GetDate();
        PrintDate();
        sleep(1);
    }
    return 0;
}

