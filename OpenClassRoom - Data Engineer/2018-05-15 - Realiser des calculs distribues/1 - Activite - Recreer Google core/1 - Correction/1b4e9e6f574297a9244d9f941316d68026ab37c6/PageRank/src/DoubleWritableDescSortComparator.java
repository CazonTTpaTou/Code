package ocr.hadoop.lab.pagerank;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.io.WritableComparator;

public class DoubleWritableDescSortComparator extends WritableComparator {

	public DoubleWritableDescSortComparator() 
	{
		super(DoubleWritable.class, true);
	}

	@Override
	public int compare(WritableComparable a, WritableComparable b) 
	{
		DoubleWritable k1 = (DoubleWritable)a;
		DoubleWritable k2 = (DoubleWritable)b;
				
		return (-k1.compareTo(k2));
	}	
}
