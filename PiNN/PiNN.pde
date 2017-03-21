/**
*  Author: Cristian Pintea (http://pintea.net)
*  Copyright 2017
*  PiNN minimalistic implementation of ANN with Backprop
*
*/

void setup(){
    NeuralNetwork nn = new NeuralNetwork(new int[]{3, 1}, 2);
    double[] output = nn.compute(new double[]{1, 1});
    for(int i = 0; i < output.length; i++){
      println(i + ": " + output[i]); 
    }
    nn.backpropagate(new double[]{1, 1}, new double[]{0});
}

void draw(){
  
}



class NeuralNetwork{
  Layer[] l;
  
  public NeuralNetwork(int layerSizes[], int inputSize){
    l = new Layer[layerSizes.length];
    l[0] = new Layer(layerSizes[0], inputSize);
    for(int i = 1; i < layerSizes.length; i++){
      l[1] = new Layer(layerSizes[i], l[i - 1]);
    }
  }
  
  double[] compute(double[] input){
    double[] lastActivations;
    lastActivations = l[0].fire(input);
    for(int i = 1; i < l.length; i++){
      lastActivations = l[i].fire(lastActivations);  
    }
    return lastActivations;
  }
  
  void backpropagate(double[] input, double[] expOutput){   
    double[] output = compute(input);
    float firstCost = cost(output, expOutput);
    
    //Output layer
    double[] newNeurons = new double[l[0].size];
      for(int nn = 0; nn < l[ln].size; nn++){
        for(int wn = 0; wn < l[ln].n[nn].w.length; wn++) {
          
        }
      }
    
    for(int ln = l.length - 2; ln >= 0; ln--){
      newNeurons = new double[l[0].size];
      for(int nn = 0; nn < l[ln].size; nn++){
        for(int wn = 0; wn < l[ln].n[nn].w.length; wn++) {
          
        }
      }
    }
    

    double[] _output = output;
    _output[0] += 0.1;
    double pdCostOutput = cost(_output, expOutput) - firstCost;
    double[] in = l[1].n[0].input;
    in[0] += 0.1;
    _output[0] = l[1].n[0].compute(in);
    double pdOutputWeight = output[0] - _output[0];
    double pdCostWeight = pdOutputWeight * pdCostOutput;
    
  }
  
  float cost(double[] output, double[] expOutput){
    float cost = 0;
    for(int i = 0; i < output.length; i++){
      cost += abs((float)(output[i] - expOutput[i]));
    }
    return cost;
  }
  
}

class Layer{
  int size;
  Layer prevLayer;
  Neuron[] n;
  double[] activations;
  
  public Layer(int size, Layer prevLayer){
    this.size = size;
    this.prevLayer = prevLayer;
    n = new Neuron[size];
    for(int i = 0; i < size; i++){
      n[i] = new Neuron(prevLayer.size);
    }
    activations = new double[size];
  }
  
  public Layer(int size, int inputSize){
    this.size = size;
    n = new Neuron[size];
    for(int i = 0; i < size; i++){
      n[i] = new Neuron(inputSize);
    }
    activations = new double[size];
  }
  
  double[] fire(double[] activations){
    for(int i = 0; i < n.length; i++){
      this.activations[i] = n[i].compute(activations);
    }
    return this.activations;
  }
  
}

class Neuron{
  int synapses;
  double[] w;
  double[] pdCostWeight;
  double bias = 0;
  double[] input;
  double weightedInput;
  
  public Neuron(int synapses){
    this.synapses = synapses;
    w = new double[synapses];
    for(int i = 0; i < w.length; i++){
      w[i] = random(-1, 1);
    }
    pdCostWeight = new double[w.length];
  }
  
  public Neuron(double[] weights, double bias){
    synapses = weights.length;
    this.w = weights;
    this.bias = bias;
  }
  
  public double compute(double[] input){
    this.input = input;
    double[] weightedInputs = vectorMultiply(input, w);
    for(int i = 0; i < weightedInputs.length; i++){
      weightedInputs[i] += bias;
    }
    weightedInput = vectorSum(weightedInputs);
    return sigmoid(weightedInput);
  }
}

double[] vectorMultiply(double[] a, double[] b){
  double[] a_ = a;
  for(int i = 0; i < a_.length && i < b.length; i++){
      a_[i] *= b[i];
  }
  return a_;
}

double vectorSum(double[] a){
  double sum = 0;
  for(int i = 0; i < a.length; i++){
    sum += a[i];
  }
  return sum;
}

double sigmoid(double x){
  return 1 / (1 + Math.exp(-x));
}