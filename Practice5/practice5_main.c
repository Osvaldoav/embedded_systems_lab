#include <bcm2835.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>

typedef char bool;
#define true 1
#define false 0

#define MAX_LEN 32

uint8_t data;
char buf[MAX_LEN];


const char reset_clock_buffer[8] = { 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
// Buffer with date: Mon 12:00 AM 01/01/01
const char initialize_clock_buffer[8] = { 0x00, 0x00, 0x00, 0x52, 0x01, 0x01, 0x01, 0x01 };

const char reset_temp_buffer[8] = { 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
// Buffer with date: Mon 12:00 AM 01/01/01
const char initialize_temp_buffer[8] = { 0x00, 0x00, 0x00, 0x52, 0x01, 0x01, 0x01, 0x01 };

const char *days[7] = {"Mon", "Tue", "Wen", "Thu", "Fri", "Sat", "Sun"};
const char *ampm[2] = {"AM", "PM"};

const uint8_t clock_slave_address = 104; //0x68
const uint8_t temp_slave_address = 77; //0x68
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

void GetDate(){
    // Move to position 0.
    const char point_to[] = {0x00};
    bcm2835_i2c_write(point_to, 1);   
    bcm2835_i2c_read(buf, 7); 
}

void PrintDate() {
    char cDay, cMonth, cYear, cSeconds, cMinutes, cHours;
    int iWeekDay, iAmPm;
    // Day is register zero with mask 0011 1111
    cDay = (buf[4] & 0x3F) % 0x32;
    // Month is register zero with mask 0001 1111
    cMonth = (buf[5] & 0x1F) % 0x13;
    // Year is register zero with mask 0001 1111
    cYear = (buf[6]) % 0x9A;
    // Day of week
    iWeekDay = ((int)((buf[3] & 0x07) % 0x07) - 1);
    // Hours
    cHours = (buf[2] & 0x1F) % 0x13;
    // Minutes
    cMinutes = (buf[1] & 0x7F) % 0x61;
    // Seconds
    cSeconds = (buf[0] & 0x7F) % 0x61;
    // AM or PM
    iAmPm = (buf[2] & 0x20) >> 4;
    printf("%02x/%02x/%02x %s %02x:%02x:%02x %s\n", cDay, cMonth, cYear, days[iWeekDay % 7], cHours, cMinutes, cSeconds, ampm[iAmPm % 2]);
}

void ReadAndPrintClock() {
    bcm2835_i2c_setSlaveAddress(clock_slave_address);

    GetDate();
    PrintDate();
}

void GetTemp() {
    // Move to position 0.
    const char point_to[] = {0x00};
    bcm2835_i2c_write(point_to, 1);   
    bcm2835_i2c_read(buf, 1);
}

void PrintTemp() {
    printf("%x\n", buf[0]);
}

void ReadAndPrintTemp() {
    bcm2835_i2c_setSlaveAddress(temp_slave_address);

    GetTemp();
    PrintTemp();
}

int main(int argc, char **argv) {

    if(!InitializeBcm2835()) {
        return 1;
    }

    InitializeClock();

}

int main(int argc, char **argv) {

    if(!InitializeBcm2835()) {
        return 1;
    }

    InitializeClock();

    while(true) {
        ReadAndPrintClock();
        sleep(1);
    }
    return 0;
}

