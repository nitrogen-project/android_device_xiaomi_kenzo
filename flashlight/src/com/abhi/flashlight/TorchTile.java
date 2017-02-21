package com.abhi.flashlight;

import android.graphics.drawable.Icon;
import android.service.quicksettings.Tile;
import android.service.quicksettings.TileService;

/**
 * Created by Abhishek on 26-01-2017.
 */

public class TorchTile extends TileService {

    @Override
    public void onStartListening() {
        super.onStartListening();
        updateTile();
    }

    @Override
    public void onClick() {
        super.onClick();
        if (isTorchEnabled() ? Utils.writeLine(Constants.PATH, "0") : Utils.writeLine(Constants.PATH, "100"))
        updateTile();
    }

    public boolean isTorchEnabled() {
        return (Utils.readOneLine(Constants.PATH).equals("100"));
    }

    public void updateTile() {
        if (isTorchEnabled()) {
            getQsTile().setIcon(Icon.createWithResource(this, R.drawable.ic_flashlight_on));
            getQsTile().setState(Tile.STATE_ACTIVE);
        } else {
            getQsTile().setIcon(Icon.createWithResource(this, R.drawable.ic_flashlight_off));
            getQsTile().setState(Tile.STATE_INACTIVE);
        }
        getQsTile().updateTile();
    }
}