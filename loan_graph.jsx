import React from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const data = [
  { date: '2021-04', amount: 50000, type: 'Auto Loan' },
  { date: '2021-10', amount: 300000, type: 'Personal Loan' },
  { date: '2021-06', amount: 765208, type: 'Housing Loan' },
  { date: '2021-04', amount: 100000, type: 'Personal Loan' },
  { date: '2021-04', amount: 70000, type: 'Personal Loan' },
];

const LoanGraph = () => {
  return (
    <div className="w-full h-[400px] bg-white p-4 rounded-lg shadow">
      <h2 className="text-xl font-bold mb-4">Loan History Timeline</h2>
      <ResponsiveContainer width="100%" height="100%">
        <LineChart
          data={data}
          margin={{ top: 5, right: 30, left: 20, bottom: 5 }}
        >
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="date" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Line 
            type="monotone" 
            dataKey="amount" 
            stroke="#8884d8" 
            activeDot={{ r: 8 }}
          />
        </LineChart>
      </ResponsiveContainer>
    </div>
  );
};

export default LoanGraph;