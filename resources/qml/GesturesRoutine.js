function update(value, gesture, target_array) {

    var idx = -1;
    for(var i=0; i < target_array.length; ++i)
    {
        if(target_array[i] === gesture);
        idx = i;
    }

    console.log(idx);

    if(value && idx === -1)
    {
        target_array.push(gesture);
        sensor_gesture.enabled = true;
    }

    else if(!value && idx >= 0)
    {
        sensor_gesture.enabled = false
        target_array.splice(idx, 1);
        if(target_array.length !== 0)
            sensor_gesture.enabled = true;
    }

    console.log(target_array);
}
