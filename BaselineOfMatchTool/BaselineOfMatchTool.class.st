"
A baseline of MatchTool…
"
Class {
	#name : #BaselineOfMatchTool,
	#superclass : #BaselineOf,
	#category : 'BaselineOfMatchTool'
}

{ #category : #baseline }
BaselineOfMatchTool >> baseline: spec [
	<baseline>
	
	spec for: #( #'pharo8.x') do: [ spec package: 'MatchTool' ]
	

	
]
