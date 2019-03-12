const util = require( "util");
const exec = util.promisify( require( "child_process").exec );

module.exports = {
  get_gpu_usage: async function() {
    var g_stdout;
    try {
      const { stdout, stderr } = await exec( "nvidia-smi -q -x");
      g_stdout = stdout;
    }
    catch( error) {
      console.log( error);
    }

    return g_stdout;
  },
  // Linux Uname command wrapper
  get_nodename: async function() {
    var tmp;
    try {
      const { stdout, stderr } = await exec( "uname -n");
      tmp = stdout;
    }
    catch( error) {
      console.log( error);
    }
  },
  get_kernelname: async function() {
    var tmp;
    try {
      const { stdout, stderr } = await exec( "uname -s");
      tmp = stdout;
    }
    catch( error) {
      console.log( error);
    }
  },
  get_kernel_release: async function() {
    var tmp;
    try {
      const { stdout, stderr } = await exec( "uname -r");
      tmp = stdout;
    }
    catch( error) {
      console.log( error);
    }
  },
  get_os: async function() {
    var tmp;
    try {
      const { stdout, stderr } = await exec( "uname -o");
      tmp = stdout;
    }
    catch( error) {
      console.log( error);
    }
  }
}
