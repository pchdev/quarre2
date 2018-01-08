function speakerpos_x(i, n)
{
    return (Math.cos(i/n * Math.PI*2) + 1) / 2;
}

function speakerpos_y(i, n)
{
    return (Math.sin(i/n * Math.PI*2) + 1) / 2
}
