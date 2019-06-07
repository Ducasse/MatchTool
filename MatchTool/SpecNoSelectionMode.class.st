Class {
	#name : #SpecNoSelectionMode,
	#superclass : #SpecAbstractSelectionMode,
	#category : #'MatchTool-ExtraSpec'
}

{ #category : #adding }
SpecNoSelectionMode >> addSubscription: aSubscription [

]

{ #category : #selecting }
SpecNoSelectionMode >> basicSelectIndex: indexToSelect [
]

{ #category : #selecting }
SpecNoSelectionMode >> includesIndex: anIndex [
	^false
]

{ #category : #selecting }
SpecNoSelectionMode >> includesItem: anItem [
	^false
]

{ #category : #selecting }
SpecNoSelectionMode >> isEmpty [
	^true
]

{ #category : #selecting }
SpecNoSelectionMode >> isMultipleSelection [
	^false
]

{ #category : #selecting }
SpecNoSelectionMode >> selectAll [
]

{ #category : #selecting }
SpecNoSelectionMode >> selectIndexes: aCollection [
]

{ #category : #selecting }
SpecNoSelectionMode >> selectItems: aCollection [
]

{ #category : #selecting }
SpecNoSelectionMode >> selectedIndexes [
	^#()
]

{ #category : #selecting }
SpecNoSelectionMode >> subscriptions [
	^#()
]

{ #category : #selecting }
SpecNoSelectionMode >> unselectAll [
]

{ #category : #selecting }
SpecNoSelectionMode >> unselectIndex: anInteger [ 
]

{ #category : #selecting }
SpecNoSelectionMode >> whenChangedDo: aBlockClosure [ 
]
