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

#import <Foundation/Foundation.h>

// access to the built-in accelerometer, independ from Springboard
// TODO: for other applications, it could have a gravityChangeX:Y:Z: delegate
@interface Accelerometer : NSObject {
	float _currentX;
	float _currentY;
	float _currentZ;
}

// get shared instance
+(Accelerometer*)instance;

// init with sampling frequency
-(id)initWithHertz:(int)hertz;

-(float)currentX;
-(float)currentY;
-(float)currentZ;
-(void)setCurrentX:(float)x Y:(float)y Z:(float)z;
@end
