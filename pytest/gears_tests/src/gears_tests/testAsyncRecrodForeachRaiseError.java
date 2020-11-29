package gears_tests;

import gears.GearsBuilder;
import gears.GearsFuture;
import gears.readers.KeysReader;

public class testAsyncRecrodForeachRaiseError {
	public static void main() {
		KeysReader reader = new KeysReader();
		GearsBuilder.CreateGearsBuilder(reader).map(r->r.getKey()).
		asyncForeach(r->{
			GearsFuture<String> f = new GearsFuture<String>();
			new Thread(new Runnable() {
				
				@Override
				public void run() {
					try {
						Thread.sleep(1000);
						
						f.setError("error");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}					
				}
			}).start();
			return f;
		}).run();
	}
}
