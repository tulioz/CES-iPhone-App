package edu.ucdavis.events;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import com.markupartist.android.widget.ActionBar;

public class HomeActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        final ActionBar actionbar = (ActionBar) findViewById(R.id.actionbar);
        actionbar.setTitle("UCD Events");
//        actionbar.setHomeAction(new IntentAction(this, HomeActivity.createIntent(this), R.drawable.title));     
    }
    
    public void onRestaurantsClick(View v) {
    	startActivity(new Intent(this, LocationsActivity.class));
    }
    
    public static Intent createIntent(Context context) {
    	Intent i = new Intent(context, HomeActivity.class);
    	i.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
    	return i;
    }
}