using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using System;

namespace Quantum.Bell
{
	class Driver
	{
		static void Main(string[] args)
		{
			using (var sim = new QuantumSimulator())
			{
				// Try initial balues
				Result[] initials = new Result[] { Result.Zero, Result.One };

				foreach (Result initial in initials)
				{
					//var res = BellTest.Run(sim, 1000, initial).Result;
					var res = Bell50.Run(sim, 1000, initial).Result;
					var (numZeros, numOnes) = res;
					Console.WriteLine($"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4}");
				}
			}

			using (var sim = new QuantumSimulator())
			{
				// Try initial values
				Result[] initials = new Result[] { Result.Zero, Result.One };

				foreach (Result initial in initials)
				{
					var res = BellEntangle.Run(sim, 1000, initial).Result;
					var (numZeros, numOnes, agree) = res;
					Console.WriteLine($"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4} agree={agree,-4}");
				}
			}

			Console.ReadLine();
		}
	}
}
