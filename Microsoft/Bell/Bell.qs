namespace Quantum.Bell
{
    open Microsoft.Quantum.Primitive;

	// This operation may now be called to set a qubit in a known state (Zero or One)
	// We measure the qubit, if it's in the state we want, we leave it alone, otherwise, we flip it with the X gate.
	operation Set (desired: Result, q1: Qubit) : ()
	{
		body
		{
			let current = M(q1);

			if (desired != current)
			{
				X(q1);
			}
		}
	}

	operation BellTest (count : Int, initial: Result) : (Int,Int)
	{
		body
		{
			mutable numOnes = 0;

			using (qubits = Qubit[1])
			{
				for (test in 1..count)
				{
					Set (initial, qubits[0]);
					// X Gate - qubit flip 1 to 0 or 0 to 1
					//X(qubits[0]);
					// Hadamard gate - flip a qubit halfway
					H(qubits[0]);
					let res = M (qubits[0]);

					// Count the number of ones we saw:
					if (res == One)
					{
						set numOnes = numOnes + 1;
					}
				}
				Set(Zero, qubits[0]);
			}
			// Return number of times we saw a |0> and number of times we saw a |1>
			return (count-numOnes, numOnes);
		}
	}

	operation Bell50(count : Int, initial: Result) : (Int,Int)
	{
		body
		{
			mutable numOnes = 0;

			using (qubits = Qubit[2])
			{
				for (test in 1..count)
				{
					// This will allow us to add a new gate (CNOT) before we measure (M) in Bell50
					Set (initial, qubits[0]);
					Set (Zero, qubits[1]);

					H(qubits[0]);
					CNOT(qubits[0],qubits[1]);
					let res = M (qubits[0]);

					// Count the number of ones we saw:
					if (res == One)
					{
						set numOnes = numOnes + 1;
					}
				}

				// Now we need to reset the second qubit before releasing it (this could also be done with a for loop).
				// We'll add a line after qubit 0 is reset
				Set(Zero, qubits[0]);
				Set(Zero, qubits[1]);
			}

			// Return number of times we saw a |0> and number of times we saw a |1>
			return (count-numOnes, numOnes);
		}
	}

	operation BellEntangle(count : Int, initial: Result) : (Int,Int,Int)
	{
		body
		{
			mutable numOnes = 0;
			mutable agree = 0;

			using (qubits = Qubit[2])
			{
				for (test in 1..count)
				{
					Set(initial, qubits[0]);
					Set(Zero, qubits[1]);

					H(qubits[0]);
					CNOT(qubits[0],qubits[1]);
					let res = M(qubits[0]);

					if (M (qubits[1]) == res)
					{
						set agree = agree + 1;
					}

					// Count the number of ones we saw:
					if (res == One)
					{
						set numOnes = numOnes + 1;
					}
				}
				Set(Zero, qubits[0]);
				Set(Zero, qubits[1]);
			}
			// Return number of times we saw a |0> and number of times we saw a |1>
			return (count-numOnes, numOnes, agree);
		}
	}
}
