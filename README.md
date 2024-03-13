# BirdSense
## About
### Problem

Monitoring bird populations currently requires the work of specialists and enthusiasts, which is a time-consuming solution. Additionally, there is a shortage of trained individuals for this task.Our project focuses on implementing a network of sensors to monitor bird species appearing in a specific area during certain periods. The project targets foresters and ornithologists due to its potential applications in monitoring endangered species and observing bird migrations. Furthermore, the solution serves as an excellent tool for hobbyists.

### Our solution

We aim to create a system capable of monitoring bird activity in a designated area without human intervention. Our plan is to develop a network of sensors that record sounds and recognize bird species based on their calls. These sensors will be installed, often by individuals with little experience in similar technologies (e.g., foresters), in areas where bird presence needs to be studied, such as forests, parks, etc. We should consider the possibility of collecting data from sensors located far from populated areas.

### System architecture

Considering the above requirements, we have decided on the following system architecture:
- Sensors: Positioned in the field, these sensors record sound and analyze it to recognize the species of recorded birds.
- Data Transmission: Sensor data is transmitted using the LoRaWAN protocol to a server. We utilize The Things Network.
- Transmitted Data: The transmitted data includes the recognized bird species, the recording end time, and the confidence coefficient.
- Server: The server with a database collects data from sensors and provides it to the application. Communication between the server and both The Things Network and the mobile application is facilitated through a REST API.
- Mobile app: The application enables users to display and analyze data from sensors.

## Hardware

## Software

### Raspberry Pi

### The Things Network

### Mobile app

## Setup

