clear ; close all; clc
trainData = readtable("training_data.csv",'TextType','string');
head(trainData)
textData = trainData.listedproductname;
labels = trainData.commonproductname;
documents = preprocessWeatherNarratives(textData);
documents(1:5)
bag = bagOfWords(documents);
mdl = fitlda(bag,20);
testData = readtable("test_data.csv",'TextType','string');
testData = testData.listedproductname;
m=size(testData);
for i = 1:m
    newdoc = testData(i);
    TEdocuments = preprocessText(newdoc);
    newDocument = tokenizedDocument(TEdocuments); 
    iterationLimit = 100;
    [topicIdx,scores] = predict(mdl,newDocument, ...
    'IterationLimit',iterationLimit);
    A(i,1) = newdoc;
    A(i,2) = topicIdx;
    A(i,3) = labels(topicIdx);
    A(i,4) = max(scores);
end
disp(A)



