/*
	Copyright 2020 Mohamed Shalan

	Author: Mohamed Shalan (mshalan@aucegypt.edu)

	This file is auto-generated by wrapper_gen.py on 2023-10-30

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/


#ifndef IO_TYPES
#define IO_TYPES
#define   __R     volatile const unsigned int
#define   __W     volatile       unsigned int
#define   __RW    volatile       unsigned int
#endif

#define WDT_CONTROL_REG_EN		0
#define WDT_CONTROL_REG_EN_LEN	1
#define WDT_WDTOV_FLAG	0x1

typedef struct {
	__R 	timer;
	__RW	load;
	__RW	control;
	__R 	reserved[957];
	__W 	icr;
	__R 	ris;
	__RW	im;
	__R 	mis;
} WDT_TYPE;
