function speakerpos_x(i, n)
{
    // otherwise Math.cos / Math.sin functions
    // don't get reevaluated in Repeater
    return (Math.cos(i/n * Math.PI*2) + 1) / 2;
}

function speakerpos_y(i, n)
{
    return (Math.sin(i/n * Math.PI*2) + 1) / 2
}
