package edu.ucdavis.events;

import android.app.Activity;
import android.os.Bundle;

import com.markupartist.android.widget.ActionBar;
import com.markupartist.android.widget.ActionBar.IntentAction;

public class LocationsActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.location);
		
		final ActionBar actionbar = (ActionBar) findViewById(R.id.actionbar);
		actionbar.setHomeAction(new IntentAction(this, HomeActivity.createIntent(this), R.drawable.ic_title_home_default));
		actionbar.setTitle("Locations");
	}

}
