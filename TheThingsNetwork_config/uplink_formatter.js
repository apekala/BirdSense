function Decoder(bytes, port) {

    var lines = String.fromCharCode.apply(null, bytes).replace(/;$/, '').split(';');

    let detections = [];
    lines.forEach((line) => {
      line = line.split(',')
      detections.push({
        species: line[0],
        confidence: line[1],
        end_time: line[2],

        // confidence: parseFloat(line[1]),
        // end_time: parseInt(line[2]),
      })
    })


    return {
        data: detections
    };
}