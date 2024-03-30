// import { exec } from 'child_process';
// import { NextResponse } from 'next/server';

// export async function POST(req, res) {

//     const reqJson = await req.json();
//     const protocol = reqJson.protocol;

//     console.log("Protocol: ", protocol);

//     if (!protocol) {
//       // return res.status(400).json({ error: 'Protocol is required' });
//       return Response.json({error: 'Protocol is required'}, {status: 400});
//     }

//     // Define the path to your Python script
//     const scriptPath = 'src/app/api/exp_gen.py';

//     return Response.json("hello world");
//     // new Promise((resolve, reject) => {
//     //   exec(`python3 ${scriptPath} "${protocol}"`, (error, stdout, stderr) => {
//     //     if (error) {
//     //       console.error(`exec error: ${error}`);
//     //       reject(new Error('Failed to process the protocol'));
//     //     } else {
//     //       try {
//     //         const data = JSON.parse(stdout);
//     //         resolve(data);
//     //       } catch (parseError) {
//     //         console.error(`Error parsing JSON from Python script: ${parseError}`);
//     //         reject(new Error('Failed to parse response from Python script'));
//     //       }
//     //     }
//     //   });
//     // })
//     // .then(data => {
//     //   return Response.json({data: data}, {status: 200});
//     // })
//     // .catch(err => {
//     //   return Response.json({error: err.message}, {status: 500});
//     // });

//     // Execute the Python script using the provided protocol
//     // exec(`python3 ${scriptPath} "${protocol}"`, (error, stdout, stderr) => {
      
//     //   if (error) {
//     //     console.error(`exec error: ${error}`);
//     //     return NextResponse.json({error: 'Failed to process the protocol'}, {status: 500});
//     //   }

//     //   // Assuming stdout returns a JSON string
//     //   try {
//     //     const data = JSON.parse(stdout);
//     //     console.log('Data:', data);
//     //     // return data;
//     //     return NextResponse.json({data: data}, {status: 200});
//     //     // return res.status(200).json(data);
//     //   } catch (parseError) {
//     //     console.error(`Error parsing JSON from Python script: ${parseError}`);
//     //     return NextResponse.json({error: 'Failed to parse response from Python script'}, {status: 500});
//     //   }
//     // });
    
// }

import { exec } from 'child_process';

export async function POST(req, res) {
  const reqJson = await req.json();
  const protocol = reqJson.protocol;

  if (!protocol) {
    // Correct use of Response to directly return a response.
    return new Response(JSON.stringify({ error: 'Protocol is required' }), { status: 400 });
  }

  const scriptPath = 'src/app/api/exp_gen.py';

  // Wrapping exec in a Promise to handle it asynchronously and properly respond.
  try {
    const data = await new Promise((resolve, reject) => {
      exec(`python3 ${scriptPath} "${protocol}"`, (error, stdout, stderr) => {
        if (error) {
          console.error(`exec error: ${error}`);
          reject(new Error('Failed to process the protocol'));
        } else {
          try {
            resolve(JSON.parse(stdout));
          } catch (parseError) {
            console.error(`Error parsing JSON from Python script: ${parseError}`);
            reject(new Error('Failed to parse response from Python script'));
          }
        }
      });
    });
    return new Response(JSON.stringify({ data }), { status: 200 });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }
}
