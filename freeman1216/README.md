### Codegolfed blinky for a challenge by Lars Thomsen from stm32world 

Final size : 26b

To build write
```shell
make
```
To flash (make sure openocd is installed) 
```shell
make flash
```

Includes a version that doesnt write to reserved bits on stm32f407 and for some reason doesnt work on stm32f411ce without a debugger connection

To build it write

```shell
make f407
```
To flash (make sure openocd is installed)

```shell
make flash_f407
```

If you are using ST's flashers just flash the binary at 0x08000000 

Thanks to [Piers Finlayson](https://github.com/piersfinlayson/) for his solution 

Made by freeman1216 

You can copy and use whatever you need 
