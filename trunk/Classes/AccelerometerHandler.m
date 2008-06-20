/*

 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; version 2
 of the License.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/

#include "AccelerometerHandler.h"

#include <CoreFoundation/CoreFoundation.h>
#include <IOKit/IOKitLib.h>

typedef struct {} *IOHIDEventSystemRef;
typedef struct {} *IOHIDEventRef;
float IOHIDEventGetFloatValue(IOHIDEventRef ref, int param);

void handleHIDEvent(int a, int b, int c, IOHIDEventRef ptr) {

	int type = IOHIDEventGetType(ptr);
	if (type == 12) {
		float x,y,z;
		x = IOHIDEventGetFloatValue(ptr, 0xc0000);
		y = IOHIDEventGetFloatValue(ptr, 0xc0001);
		z = IOHIDEventGetFloatValue(ptr, 0xc0002);
		[[Accelerometer instance] setCurrentX:x Y:y Z:z];
  }
}

#define expect(x) if(!x) { printf("failed: %s\n", #x);  return self; }

static Accelerometer* _accelerometerInstance = nil;

@implementation Accelerometer

-(id)initWithHertz:(int)hz;	{
	[super init];
	_accelerometerInstance = self;

	_currentX = 0.f;
	_currentY = 0.f;
	_currentZ = 0.f;

	// setup accelerometer
	mach_port_t master;
	expect(0 == IOMasterPort(MACH_PORT_NULL, &master));
	int page = 0xff00, usage = 3;
	CFNumberRef nums[2];
	CFStringRef keys[2];
	keys[0] = CFStringCreateWithCString(0, "PrimaryUsagePage", 0);
	keys[1] = CFStringCreateWithCString(0, "PrimaryUsage", 0);
	nums[0] = CFNumberCreate(0, kCFNumberSInt32Type, &page);
	nums[1] = CFNumberCreate(0, kCFNumberSInt32Type, &usage);
	CFDictionaryRef dict = CFDictionaryCreate(0, (const void**)keys, (const void**)nums, 2, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
	expect(dict);
	IOHIDEventSystemRef sys = (IOHIDEventSystemRef) IOHIDEventSystemCreate(0);
	expect(sys);
	CFArrayRef srvs = (CFArrayRef)IOHIDEventSystemCopyMatchingServices(sys, dict, 0, 0, 0);
	expect(CFArrayGetCount(srvs)==1);
	io_registry_entry_t serv = (io_registry_entry_t)CFArrayGetValueAtIndex(srvs, 0);
	expect(serv);
	CFStringRef cs = CFStringCreateWithCString(0, "ReportInterval", 0);
	int rv = 1000000/hz;
	CFNumberRef cn = CFNumberCreate(0, kCFNumberSInt32Type, &rv);
	int res = IOHIDServiceSetProperty(serv, cs, cn);
	expect(res == 1);
	res = IOHIDEventSystemOpen(sys, handleHIDEvent, 0, 0);
	expect(res != 0);

	return self;
}

-(void)setCurrentX:(float)x Y:(float)y Z:(float)z {
	_currentX = x;
	_currentY = y;
	_currentZ = z;
}

+(Accelerometer*)instance { return _accelerometerInstance; }

-(float)currentX { return _currentX; }

-(float)currentY { return _currentY; }

-(float)currentZ { return _currentZ; }

@end
